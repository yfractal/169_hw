Feature: User can manually add movie
 
Background: With some movies,and Start from Add a movie
  Given the following movies exist:
  | title                     | rating | release_date |

  | Aladdin                 | G            | 25-Nov-1992  |
  | The Terminator   | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat               | PG-13  | 5-Jan-2001   |
  | Amelie                   | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles | PG    | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run          | G      | 21-Jun-2000  |

  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page

Scenario: happy path
  When I fill in "Title" with "Men In Black"
  And I select "PG-13" from "Rating"
  And I press "Save Changes"
  Then I should be on the "Men In Black" movie page
  And I should see "Men In Black"

Scenario: sad path
	And I select "PG-13" from "Rating"
	And I press "Save Changes"
	Then I should be on the render New Movie page
	And I should see "Title can't be blank"  
