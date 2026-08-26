-- chunkname: @modules/logic/dungeon/view/DungeonRewardTipView.lua

module("modules.logic.dungeon.view.DungeonRewardTipView", package.seeall)

local DungeonRewardTipView = class("DungeonRewardTipView", BaseView)

function DungeonRewardTipView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._txtinfo = gohelper.findChildText(self.viewGO, "scrollTips/Viewport/Content/#txt_info")
	self._gorewardContentItem = gohelper.findChild(self.viewGO, "scrollTips/Viewport/Content/#go_rewardContentItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonRewardTipView:addEvents()
	return
end

function DungeonRewardTipView:removeEvents()
	return
end

function DungeonRewardTipView:_editableInitView()
	gohelper.setActive(self._gorewardContentItem, false)

	local config = lua_helppage.configDict[10801]

	self._txttitle.text = config.title
	self._txtinfo.text = config.text

	local iconText = config.iconText
	local textList = GameUtil.splitString2(iconText)

	if not textList or #textList == 0 then
		return
	end

	for i, v in ipairs(textList) do
		local title = v[1]
		local episodeId = tonumber(v[2])

		self:_addReward(title, episodeId)
	end
end

function DungeonRewardTipView:_addReward(title, episodeId)
	local go = gohelper.cloneInPlace(self._gorewardContentItem)

	gohelper.setActive(go, true)

	local titleTxt = gohelper.findChildText(go, "opentitle")

	titleTxt.text = title

	local rewardList = DungeonModel.instance:getEpisodeRewardDisplayList(episodeId)
	local content = gohelper.findChild(go, "scroll_reward/Viewport/Content")
	local commonitemicon = gohelper.findChild(go, "scroll_reward/Viewport/Content/commonitemicon")

	for i, reward in ipairs(rewardList) do
		local child = gohelper.cloneInPlace(commonitemicon)

		gohelper.setActive(child, true)

		local item = IconMgr.instance:getCommonPropItemIcon(child)

		item:setMOValue(reward[1], reward[2], reward[3])
		item:hideEquipLvAndBreak(true)
	end
end

function DungeonRewardTipView:onUpdateParam()
	return
end

function DungeonRewardTipView:onOpen()
	return
end

function DungeonRewardTipView:onClose()
	return
end

function DungeonRewardTipView:onDestroyView()
	return
end

return DungeonRewardTipView
