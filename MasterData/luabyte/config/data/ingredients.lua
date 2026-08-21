local title = {
	id = 0,
	ifCut = 0,
	cutNum = {},
	icon = {}
}

local value = {
[1001] =
{
 		id=1001,
 		cutNum={0},
 	icon={"UI/SpritePics/Item/ui_icon_item_103_01"}
},
[1002] =
{
 		id=1002,
 		cutNum={0},
 	icon={"UI/SpritePics/Item/ui_icon_item_108"}
},
[1003] =
{
 		id=1003,
 		ifCut=1,
 		cutNum={3,6},
 	icon={"UI/SpritePics/Item/ui_icon_item_102","UI/SpritePics/Item/ui_icon_item_102_01","UI/SpritePics/Item/ui_icon_item_102_02"}
},
[1004] =
{
 		id=1004,
 		ifCut=1,
 		cutNum={3},
 	icon={"UI/SpritePics/Item/ui_icon_item_103","UI/SpritePics/Item/ui_icon_item_103_01"}
},
[1005] =
{
 		id=1005,
 		ifCut=1,
 		cutNum={3,6},
 	icon={"UI/SpritePics/Item/ui_icon_item_104","UI/SpritePics/Item/ui_icon_item_104_01","UI/SpritePics/Item/ui_icon_item_104_02"}
},
[1006] =
{
 		id=1006,
 		cutNum={0},
 	icon={"UI/SpritePics/Item/ui_icon_item_105"}
},
[1007] =
{
 		id=1007,
 		ifCut=1,
 		cutNum={3},
 	icon={"UI/SpritePics/Item/ui_icon_item_101","UI/SpritePics/Item/ui_icon_item_101_01"}
},
[1008] =
{
 		id=1008,
 		ifCut=1,
 		cutNum={3,6},
 	icon={"UI/SpritePics/Item/ui_icon_item_107","UI/SpritePics/Item/ui_icon_item_107_01","UI/SpritePics/Item/ui_icon_item_107_02"}
},
[1009] =
{
 		id=1009,
 		ifCut=1,
 		cutNum={3,6},
 	icon={"UI/SpritePics/Item/ui_icon_item_106","UI/SpritePics/Item/ui_icon_item_106_01","UI/SpritePics/Item/ui_icon_item_106_02"}
}
}

return {title=title, value=value}