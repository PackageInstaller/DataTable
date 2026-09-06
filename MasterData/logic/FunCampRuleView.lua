-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampRuleView.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampRuleView", package.seeall)

local FunCampRuleView = class("FunCampRuleView", ViewComponent)

function FunCampRuleView:ctor()
	FunCampRuleView.super.ctor(self)
end

function FunCampRuleView:buildUI()
	FunCampRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._itemGos = {}

	for i = 1, 4 do
		local item = {}

		item.imgRule = self:getGo(string.format("rule_%d/imgRule", i))
		item.txtTitle = self:getTxt(string.format("rule_%d/txtTitle", i))
		item.txtTime = self:getTxt(string.format("rule_%d/txtTime", i))
		item.txtDesc = self:getTxt(string.format("rule_%d/txtDesc/Viewport/Content", i))

		table.insert(self._itemGos, item)
	end
end

function FunCampRuleView:bindEvents()
	FunCampRuleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function FunCampRuleView:unbindEvents()
	FunCampRuleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FunCampRuleView:onEnter()
	FunCampRuleView.super.onEnter(self)
	self:_initView()
end

function FunCampRuleView:onExit()
	FunCampRuleView.super.onExit(self)
	self:_removeIcon()
end

function FunCampRuleView:_initView()
	for i = 1, 4 do
		local cfg = FunCampConfig.instance:getStageDesCfg(i)

		if cfg then
			local item = self._itemGos[i]

			item.txtTitle.text = cfg.name
			item.txtDesc.text = cfg.desc

			uGuiUtil.setSpriteToImage(item.imgRule, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("funcamp", cfg.path))

			local startTime, endTime = self:_getTime(i)
			local startDate = GameUtil.string2date(startTime)
			local endDate = GameUtil.string2date(endTime)

			item.txtTime.text = string.format("%02d.%02d-%02d.%02d", startDate.month, startDate.day, endDate.month, endDate.day)
		end
	end
end

function FunCampRuleView:_removeIcon()
	for i, v in ipairs(self._itemGos) do
		uGuiUtil.clearImage(v.imgRule)
	end
end

function FunCampRuleView:_getTime(index)
	local cfg = FunCampConfig.instance:getActivityCfg(FunCampModel.instance:getActivityId())

	if cfg then
		if index == 1 then
			return cfg.selectStartTime, cfg.selectEndTime
		elseif index == 2 then
			return cfg.inspireStartTime, cfg.inspireEndTime
		elseif index == 3 then
			return cfg.battleStartTime, cfg.battleEndTime
		else
			return cfg.prizeStartTime, cfg.prizeEndTime
		end
	else
		return "2022-09-02T05:00:00", "2022-09-09T05:00:00"
	end
end

return FunCampRuleView
