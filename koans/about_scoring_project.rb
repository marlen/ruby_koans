require File.expand_path(File.dirname(__FILE__) + '/edgecase')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # You need to write this method

  hash = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0,
          6 => 0, 7 => 0, 8 => 0, 9 => 0 }

  set_of_three_numbers_ctr = 0
  number_with_3num = 0
  total = 0

  dice.each do |item|
    hash[item] += 1
    if (item == 1)
      total += 100 
    else if (item == 5)
           total += 50
         end
    end
  end

  hash.each_pair do |k,v|
    if v >= 3
       set_of_three_numbers_ctr = v
       number_with_3num = k
       break
    end
  end

  if (number_with_3num != 1) && (set_of_three_numbers_ctr >= 3)
     # 3 or more numbers except 3 ones
     total += 100 * number_with_3num 
     if (number_with_3num == 5)
        total -= 50 * 3
     end
  else if (number_with_3num == 1) && (set_of_three_numbers_ctr >= 3)
       # 3 or more ones
          total += 1000
          total -= 100 * 3
       end
  end

  
  total
end

class AboutScoringProject < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
