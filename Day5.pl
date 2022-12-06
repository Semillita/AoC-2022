use feature qw(say);
use strict;
use warnings;
use Data::Dump qw(dump);
use Storable qw(dclone);

open(FILE, '<', 'Input5.txt') or die "Failed to open file";

my @lines;
while(<FILE>) {
    push(@lines, $_);
}

my @rows;
my $line_index = 0;
while() {
    my $line = $lines[$line_index];
    $line_index++;

    my $starts_with_bracket = (rindex($line, "[", 0) == 0);
    my $starts_with_space = (rindex($line, " ", 0) == 0);

    my $is_stack = ($starts_with_bracket) || ($starts_with_space);
    my $is_that_line_with_all_the_numbers = (index($line, "1   2") == 1);
    if (!$is_stack || $is_that_line_with_all_the_numbers) {
        last;
    }

    $line =~ s/(\s\s\s\s)/#/g;
    $line =~ s/(\s|\[|\])//g;
    push(@rows, $line);
}

my @stacks;
for my $i (0..(length($rows[0]) - 1)) {
    my @stack;

    for my $j (0..$#rows) {
        my $row = ($rows[$j]);
        my $char_at = substr($row, $i, 1);
        if ($char_at ne '#') {
            push(@stack, $char_at);
        }
    }

    @stack = reverse(@stack);
    push(@stacks, \@stack);
}

my @instruction_lines = @lines[($line_index + 1)..$#lines];
my @part_1_stacks = @{dclone(\@stacks)};
my @part_2_stacks = @{dclone(\@stacks)};

foreach (@lines[($line_index + 1)..$#lines]) {
    if ($_ =~ /^move (\d+) from (\d+) to (\d+)$/) {
        for (0..(int($1) - 1)) {
            my $obj = pop(@{@part_1_stacks[int($2) - 1]});
            push(@{@part_1_stacks[int($3) - 1]}, $obj);
        }

        my @slice = splice(@{@part_2_stacks[int($2) - 1]}, -(int($1)), int($1));
        push(@{@part_2_stacks[int($3) - 1]}, @slice);
    }
}

close(FILE);

my $result_1 = "";
for my $i (0..$#part_1_stacks) {
    $result_1 = $result_1 . $part_1_stacks[$i][-1];
}

my $result_2 = "";
for my $i (0..$#part_2_stacks) {
    $result_2 = $result_2 . $part_2_stacks[$i][-1];
}

say("Part 1: " . $result_1);
say("Part 2: " . $result_2);