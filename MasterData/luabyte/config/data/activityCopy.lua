local title = {
	id = 0,
	activityId = 0,
	UIMain = "",
	UIGift = "",
	UITask = "",
	UIShop = "",
	UIReward = "",
	chapterId = 0,
	specialChapterId = 0,
	allRewardLimit = {},
	allReward = {},
	allRewardTimes = {},
	specialTime = 0,
	achievementGroupId = 0,
	itemSubType = 0,
	activityItem = 0,
	banner = ""
}

local value = {
[1] =
{
 		id=1,
 		activityId=3001,
 		UIMain="UIMasquerade",
 		UIGift="UIMasqueradeGift",
 		UITask="UIMasqueradeTask",
 		UIShop="UIMasqueradeShop",
 		UIReward="UIMasqueradeReward",
 		chapterId=401,
 		specialChapterId=402,
 		allRewardLimit={50000,80000,100000},
 		allReward={22201,22202,22203},
 		allRewardTimes={0,35,325,737,2509,3955,6098,9585,14896,21132,25848,28467,31813,37740,44950,52764,57608,60044,62296,64393,66173,67885,69442,70910,72201,73389,74412,75411,76520,77591,78745,79711,80677,81698,82821,83814,84835,85755,86634,87536,88542,89449,90416,91191,92011,92949,93873,94606,95375,96049,96839,97598,98372,99046,99740,100000},
 		specialTime=1735938000,
 		achievementGroupId=51,
 		itemSubType=1803,
 		activityItem=5018,
 	banner="UI/SpritePics/activity/ui_main_btn_jiamianwuhui"
},
[2] =
{
 		id=2,
 		activityId=2000,
 		UIMain="UIUniverse",
 		UITask="UIUniverseTask",
 		UIShop="UIUniverseShop",
 		chapterId=403,
 		specialChapterId=404,
 		specialTime=1738616400,
 		activityItem=5011,
 	banner="UI/SpritePics/activity/ui_main_btn_pxyz"
}
}

return {title=title, value=value}