#include <functional>
#include <map>
#include <vector>
#include <iostream>
#include <ctime>
#include <cstdlib>

#include "tests.hpp"

using test_map_t = std::map<std::string, std::function<void ()>>;
using namespace std::string_literals;

static const auto ALL_STRING = "all"s;

static const test_map_t TEST_MAP = {
    { "bzero"s, test_bzero },
    { "strlen"s, test_strlen },
    { "memset"s, test_memset },
    { "puts"s, test_puts },
    { "isalpha"s, test_isalpha },
    { "strlen"s, test_strlen },
    { "isdigit"s, test_isdigit },
    { "strcat"s, test_strcat },
    { "isascii"s, test_isascii },
    { "isprint"s, test_isprint }
};

static void show_usage(const std::string & prog_name)
{
    std::cerr << "Usage: " << prog_name << " [";
    if (!TEST_MAP.empty())
    {
        std::cerr << TEST_MAP.begin()->first;
        for (auto it = next(TEST_MAP.begin()); it != TEST_MAP.end(); ++it)
            std::cerr << " " << it->first;
    }
    std::cerr << "]" << std::endl;
}

static void run_all_tests()
{
    for (auto test_it: TEST_MAP)
    {
        test_it.second();
        std::cout << test_it.first << ": OK" << std::endl;
    }
}

int main(int ac, char **av)
{
    std::srand(std::time(nullptr));
    std::vector<std::string> args { av + 1, av + ac };

    if (args.empty())
    {
        show_usage(av[0]);
        return -1;
    }

    for (auto arg: args)
    {
        if (arg == ALL_STRING)
            run_all_tests();
        else
        {
            auto test_it = TEST_MAP.find(arg);
            if (test_it != TEST_MAP.end())
            {
                test_it->second();
                std::cout << arg << ": OK" << std::endl;
            }
            else
                std::cerr << "Unknown test: " << arg << std::endl;
        }
    }

    return 0;
}
