 Feature: User can manually delete movie
 
Background: With some movies
  Given the following movies exist:
  | title                     | rating | release_date |

  | Aladdin                 | G            | 25-Nov-1992  |

Scenario: deleate 
  When I delete the movie: "Aladdin"
  Then I should be on the movies page
  And I should see "Movie 'Aladdin' deleted "
