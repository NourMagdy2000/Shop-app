import 'package:shop/network/local/cache_helper.dart';

const Login ='login';
const Register ='register';
const Home='home';
String token=Cache_helper.getData(key: 'token');
const GET_CATEGORIES='categories';
const FAVORITES='favorites';
const CART='carts';
const PROFILE='profile';
const UPDATE_PROFILE='update-profile';
const SEARCH='products/search';