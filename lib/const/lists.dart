import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/views/Home%20screen/home_screen.dart';
import 'package:shopping_app/views/cart_screen/cart_screen.dart';
import 'package:shopping_app/views/category_screen/category_screen.dart';
import 'package:shopping_app/views/profile_screen/profile_screen.dart';

const socialIconList = [icFacebookLogo, icGoogleLogo, icTwitterLogo];

var navbarItem = [
  BottomNavigationBarItem(
      icon: Image.asset(
        icHome,
        width: 26,
      ),
      label: home),
  BottomNavigationBarItem(
      icon: Image.asset(
        icCategories,
        width: 26,
      ),
      label: categories),
  BottomNavigationBarItem(
      icon: Image.asset(
        icCart,
        width: 26,
      ),
      label: cart),
  BottomNavigationBarItem(
      icon: Image.asset(
        icProfile,
        width: 26,
      ),
      label: account)
];

var navBody = [
  const HomeScreen(),
  const CategoryScreen(),
  const CartScreen(),
  const ProfileScreen()
];

const slidersList = [imgSlider1, imgSlider2, imgSlider3, imgSlider4];

const secondslidersList = [imgSs1, imgSs2, imgSs3, imgSs4];

const thirdslidersList = [imgSs1, imgSs2, imgSs3, imgSs4];

const featuredList1 = [imgS1, imgS2, imgS3];
const featuredList2 = [imgS4, imgS5, imgS6];

const featturedTitles1 = [womenDress, girlsDress, girlsWatches];
const featturedTitles2 = [boysGlasses, mobilePhone, tShirts];

const categoriesList = [
  womenClothing,
  automobile,
  menclothingFashion,
  compAccess,
  kidToys,
  sports,
  jewelery,
  cellPhone,
  furniture
];
const categoriesImages = [
  imgS4,
  imgFc3,
  imgFc1,
  imgFc2,
  imgFc4,
  imgFc5,
  imgFc7,
  imgPi3,
  imgFc9
];

const itemDetailBottomList = [
  video,
  reviews,
  privacypolicy,
  returnPolicy,
  supportPolicy
];

const profileButtonList = [orders, wishList, message];
const profileButtonIcon = [icOrder, icOrder, icMessages];

const paymentmethodimg = [imgPaypal, imgStripe, imgCod];
const paymentMethods = [paypal, stripe, cod];
