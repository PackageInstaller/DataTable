-- chunkname: @modules/logic/college/controller/helper/CollegeIconHelper.lua

module("modules.logic.college.controller.helper.CollegeIconHelper", package.seeall)

local CollegeIconHelper = _M

function CollegeIconHelper.setBuildingLv(icon, lv)
	if not icon then
		return
	end

	if not lv or lv <= 0 then
		gohelper.setActive(icon, false)
	else
		gohelper.setActive(icon, true)
		UISpriteSetMgr.instance:setCollegeSprite(icon, "college_main_level_" .. lv)
	end
end

function CollegeIconHelper.setItemIcon(itemId, imageIcon)
	local itemCo = lua_college_item.configDict[itemId]
	local iconName = itemCo and itemCo.icon

	if string.nilorempty(iconName) then
		logError(string.format("指挥部道具图标配置不存在 itemId = %s", itemId))

		return
	end

	UISpriteSetMgr.instance:setCollegeSprite(imageIcon, iconName, true)
end

function CollegeIconHelper.setActorIcon(actorId, simageIcon, imageRare)
	local actorCo = lua_college_actor.configDict[actorId]
	local iconName = actorCo and actorCo.avatar

	if string.nilorempty(iconName) then
		logError(string.format("指挥部角色头像配置不存在 actorId = %s", actorId))

		return
	end

	simageIcon:LoadImage(ResUrl.getCollegeSingleBg(iconName, "headicon_small"))

	if imageRare then
		UISpriteSetMgr.instance:setCollegeSprite(imageRare, string.format("college_role_frame%s", actorCo.rarity))
	end
end

function CollegeIconHelper.setActorChessIcon(actorId, simageIcon)
	if not simageIcon then
		return
	end

	local actorCo = lua_college_actor.configDict[actorId]
	local iconName = actorCo and actorCo.pieceAsset

	if string.nilorempty(iconName) then
		gohelper.setActive(simageIcon, false)

		return
	end

	gohelper.setActive(simageIcon, true)
	simageIcon:LoadImage(ResUrl.getCollegeSingleBg(iconName, "role"))
end

return CollegeIconHelper
