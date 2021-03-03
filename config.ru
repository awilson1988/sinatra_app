require './config/environment'

use Rack::MethodOverride
use ReviewsController
use BooksController
use UsersController
run ApplicationController
