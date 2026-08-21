local title = {
	id = 0,
	type = 0,
	name = 0,
	icon = "",
	lib = 0,
	libNum = 0,
	order = 0,
	costs = {},
	refreshType = 0,
	refreshRecover = 0,
	openCondition = {}
}

local value = {
[101] =
{
 		id=101,
 		type=1,
 		name=200002,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		lib=200002,
 		libNum=14,
 		order=3,
 		costs={64},
 		refreshType=3,
 	openCondition={}
},
[102] =
{
 		id=102,
 		type=1,
 		name=200003,
 		icon="UI/SpritePics/shop/ui_shop_icon_xf",
 		lib=200006,
 		libNum=12,
 		order=1,
 		costs={61},
 		refreshType=2,
 	openCondition={}
},
[103] =
{
 		id=103,
 		type=1,
 		name=200000,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		lib=200004,
 		libNum=10,
 		order=2,
 		costs={62},
 		refreshType=5,
 		refreshRecover=24,
 	openCondition={}
},
[104] =
{
 		id=104,
 		type=1,
 		name=200045,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		lib=200007,
 		libNum=8,
 		order=4,
 		costs={63},
 		refreshType=5,
 		refreshRecover=24,
 	openCondition={}
},
[201] =
{
 		id=201,
 		type=2,
 		name=200038,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		libNum=9,
 		order=5,
 		costs={6},
 		refreshType=1,
 	openCondition={}
},
[202] =
{
 		id=202,
 		type=3,
 		name=200048,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		order=6,
 		costs={6},
 		refreshType=1,
 	openCondition={}
},
[301] =
{
 		id=301,
 		type=6,
 		name=200048,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		refreshType=1,
 	openCondition={}
},
[401] =
{
 		id=401,
 		type=7,
 		name=200048,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		refreshType=1,
 	openCondition={}
},
[501] =
{
 		id=501,
 		type=5,
 		name=6224,
 		icon="UI/SpritePics/shop/ui_shop_icon_cg",
 		libNum=2,
 		costs={6},
 	openCondition={}
}
}

return {title=title, value=value}