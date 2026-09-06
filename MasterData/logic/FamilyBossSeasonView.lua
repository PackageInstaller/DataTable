-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilyBossSeasonView.lua

module("logic.extensions.familyteamplay.view.FamilyBossSeasonView", package.seeall)

local FamilyBossSeasonView = class("FamilyBossSeasonView", TableViewComponent)

function FamilyBossSeasonView:ctor()
	FamilyBossSeasonView.super.ctor(self)

	self._curViewDatas = nil
end

function FamilyBossSeasonView:bindEvents()
	FamilyBossSeasonView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilyBossSeasonView:unbindEvents()
	FamilyBossSeasonView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilyBossSeasonView:onExit()
	FamilyBossSeasonView.super.onExit(self)
end

function FamilyBossSeasonView:destroyUI()
	FamilyBossSeasonView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilyBossSeasonView:buildUI()
	FamilyBossSeasonView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function FamilyBossSeasonView:onEnter()
	FamilyBossSeasonView.super.onEnter(self)

	self._params = self:getFirstParam()
	self._curViewDatas = FamilyteamplayConfig.instance:getTeamPlayWarZoneCfgs()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---家族围剿  FamilyBossSeasonView:onEnter()    赛区战区")

		return
	end

	self._tableview:ReloadData()
end

function FamilyBossSeasonView:_getPath()
	return {
		cellPath = "itemGo",
		viewPath = "itemListSR"
	}
end

function FamilyBossSeasonView:_cellSize()
	return 240, 306
end

function FamilyBossSeasonView:_updateCell(view, cell, data)
	local iconGo = goutil.findChild(cell, "iconGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local lockGo = goutil.findChild(cell, "lockGo")

	GameUtil.asBtn(cell):RemoveClickListener()
	uGuiUtil.clearImage(iconGo)

	local path = string.format("ui/bigbg/familytpboss/%s.png", data.icon)

	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, path)

	nameTxt.text = data.name

	local count = self._params and tostring(checknumber(self._params[cell.data])) or 0

	countTxt.text = "当前家族数：" .. count

	GameUtil.SetActive(lockGo, not data.isOpen)
	GameUtil.asBtn(cell):AddClickListener(function()
		self:_onClickPlayItemBtn(data)
	end, self)
end

function FamilyBossSeasonView:_onClickPlayItemBtn(cfg)
	if cfg == nil or cfg.zoneId == nil then
		return
	end

	local content = string.format("确定是否参加%s战区？", cfg.name)

	local function callback()
		if not cfg.isOpen then
			FloatWordMgr.instance:show("暂未开放，敬请期待！")

			return
		end

		local baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()
		local familyId = FamilyModel.instance:getFamilyId()

		FamilyteamplayController.instance:csSendChooseTeamPlayWarZoneReq(baseInfo.periodId, cfg.zoneId, familyId)
		self:close()
	end

	TipsFacade.instance:openPopupWindow(lang("参加战区"), content, callback, nil, lang("confirm"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
end

return FamilyBossSeasonView
