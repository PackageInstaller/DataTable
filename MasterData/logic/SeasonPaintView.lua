-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPaintView.lua

module("logic.extensions.season.view.SeasonPaintView", package.seeall)

local SeasonPaintView = class("SeasonPaintView", ViewComponent)

function SeasonPaintView:ctor()
	SeasonPaintView.super.ctor(self)
end

function SeasonPaintView:unbindEvents()
	SeasonPaintView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSet:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
end

function SeasonPaintView:bindEvents()
	SeasonPaintView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSet:AddClickListener(self._onClickSetting, self)
	self._btnCheck:AddClickListener(self._onClickCheck, self)
end

function SeasonPaintView:buildUI()
	SeasonPaintView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSet = self:getBtn("btnSet")
	self._btnCheck = self:getBtn("btnCheck")
	self._txtTitle = self:getTxt("txtTitle")
	self._goPaintRoot = self:getGo("paint")
	self._sgEffectGo = self:getGo("sgEffect")
	self._goImgMaskItems = {}

	for i = 1, 10 do
		self._goImgMaskItems[i] = goutil.findChild(self._goPaintRoot, "lock_" .. i)
	end
end

function SeasonPaintView:onExit()
	SeasonPaintView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)
	self:_removeSgEffect()
end

function SeasonPaintView:onEnter()
	SeasonPaintView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)

	local params = self:getOpenParam()
	local seasonId = checknumber(params[1])
	local bNeedSgEffect = checkbool(params[2])

	SeasonController.instance:sendGetSeasonInfo(seasonId)

	if bNeedSgEffect then
		self:_addSgEffect()
	end
end

function SeasonPaintView:_removeSgEffect()
	if self._sgEffect then
		UIEffectManager.instance:stopEffect(self._sgEffect)

		self._sgEffect = nil
	end
end

function SeasonPaintView:_addSgEffect()
	self:_removeSgEffect()

	local effectPath = "20221028/xiaoshizhilei/fx_ui_saoguang_xiaoshizhilei.prefab"
	local eff = UIEffectManager.instance:playEffect(self, effectPath, self._sgEffectGo.transform, 0, 0, false, nil, function()
		self:_removeSgEffect()

		local cfg = SeasonConfig.instance:getSeasonFragmentBaseDataConfigBySeasonId(self._viewData.seasonId)

		if cfg and cfg[1] then
			UIStateManager.instance:open(ViewName.SeasonPlotPlayView, cfg[1])
		end
	end, nil, self)

	eff:setParent(self._sgEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._sgEffect = eff
end

function SeasonPaintView:_refreshView()
	local seasonId = SeasonModel.instance:getSeasonId()
	local data = SeasonModel.instance:getSeasonInfoData(seasonId)

	if not data then
		return
	end

	self._viewData = data

	for i = 1, 10 do
		goutil.setActive(self._goImgMaskItems[i], table.indexof(data.emakiFragmentIds, i) == false)
	end

	self._txtTitle.text = ""

	uGuiUtil.clearImage(self._goPaintRoot)

	local cfg = SeasonConfig.instance:getSeasonFragmentBaseDataConfigBySeasonId(data.seasonId)

	if cfg and cfg[1] then
		self._txtTitle.text = cfg[1].paintName

		local bigBgUrl = "ui/bigbg/season/" .. cfg[1].paintTexture .. ".png"

		uGuiUtil.setSpriteToImage(self._goPaintRoot, uGuiUtil.SpriteType.BigBg, bigBgUrl)
	end
end

function SeasonPaintView:_onClickSetting()
	self:close()
	UIStateManager.instance:push(ViewName.SystemSetting, 5)
end

function SeasonPaintView:_onClickCheck()
	UIStateManager.instance:push(ViewName.SeasonpaintpopupView)
end

function SeasonPaintView:_onClickClose()
	self:close()
end

return SeasonPaintView
