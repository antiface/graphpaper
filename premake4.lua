if _ACTION == "clean" then
    -- clean up manually generated files
    os.execute "rm -f sample.database"
    os.execute "rm -f src/tests/AllTests.c"
else
    -- manually generate some files
    os.execute "sqlite3 sample.database < sampledata.sql"
    os.execute "cd src/graphpaper && ../cutest/make-tests.sh > ../test/AllTests.c"
end

solution "graphpaper"
    language "C"
    configurations {"release", "debug"}
    project "graphpaper"
        files "src/graphpaper/**.c"
        kind "StaticLib"
    project "graphtest"
        files {"src/cutest/CuTest.c", "src/test/**.c"}
        includedirs "src/cutest"
        kind "ConsoleApp"
        links "graphpaper"
