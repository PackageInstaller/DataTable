-- chunkname: @modules/logic/fight/view/FightSystemFightNoticeView.lua

module("modules.logic.fight.view.FightSystemFightNoticeView", package.seeall)

local FightSystemFightNoticeView = class("FightSystemFightNoticeView", FightBaseView)

function FightSystemFightNoticeView:onInitView()
	self.click = gohelper.findChildClick(self.viewGO, "closeClick")
	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self.text1 = gohelper.findChildText(self.viewGO, "root/target1/txt_name")
	self.text2 = gohelper.findChildText(self.viewGO, "root/target2/txt_name")
end

function FightSystemFightNoticeView:addEvents()
	self:com_registClick(self.click, self.closeThis)
end

function FightSystemFightNoticeView:removeEvents()
	return
end

function FightSystemFightNoticeView:onOpen()
	local config = lua_teaching_episode.configDict[FightDataHelper.fieldMgr.episodeId]
	local teaching = config.teaching
	local list = {}

	for _, v in pairs(lua_teaching_episode.configDict) do
		if v.teaching == teaching then
			table.insert(list, v)
		end
	end

	table.sort(list, FightSystemFightNoticeView.sortConfig)

	if list[1] then
		self.text1.text = list[1].detail or ""
	end

	if list[2] then
		self.text2.text = list[2].detail or ""
	end

	local aniName = config == list[1] and "open1" or "open2"

	self.animator:Play(aniName, 0, 0)
end

function FightSystemFightNoticeView.sortConfig(a, b)
	return a.id < b.id
end

function FightSystemFightNoticeView:onClose()
	return
end

function FightSystemFightNoticeView:onDestroyView()
	return
end

return FightSystemFightNoticeView
