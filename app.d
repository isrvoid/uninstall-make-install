import std.getopt;
import std.file;
import std.algorithm;
import std.array;
import std.typecons;

void main(string[] args)
{
	string sample, root;
	auto opt = getopt(args,
			config.required,
			"sample", "Clean install sample.", &sample,
			config.required,
			"root", "Install root to be uninstalled.", &root);

	if (opt.helpWanted)
	{
		defaultGetoptPrinter("Uninstalls stuff installed with 'make install'.", opt.options);
		return;
	}

	auto dirsAndRest = getDirsAndRest(sample, root);

	removeFiles(dirsAndRest[1]);
	removeDirs(dirsAndRest[0]);
}

auto getDirsAndRest(string sample, string root)
{
	Appender!(string[]) dirs;
	Appender!(string[]) rest;
	foreach (e; dirEntries(sample, SpanMode.breadth))
	{
		auto path = e.name.replaceFirst(sample, root);
		if (e.isDir)
			dirs.put(path);
		else
			rest.put(path);
	}
	return tuple(dirs.data, rest.data);
}

void removeFiles(string[] files)
{
	foreach(f; files)
		remove(f);
}

void removeDirs(string[] dirs)
{
	import std.range : retro;
	foreach(d; dirs.sort().retro())
	{
		try
			rmdir(d);
		catch (Exception e) { }
	}
}
