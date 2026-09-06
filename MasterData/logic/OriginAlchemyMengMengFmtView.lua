-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengFmtView.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengFmtView", package.seeall)

local OriginAlchemyMengMengFmtView = class("OriginAlchemyMengMengFmtView", ViewComponent)

function OriginAlchemyMengMengFmtView:ctor()
	OriginAlchemyMengMengFmtView.super.ctor(self)
end

function OriginAlchemyMengMengFmtView:unbindEvents()
	OriginAlchemyMengMengFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnUse)
	GameUtil.rmClickHandler(self._btnFold)
end

function OriginAlchemyMengMengFmtView:bindEvents()
	OriginAlchemyMengMengFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnUse, self._onClickBtnUse, self)
	GameUtil.addClickHandler(self._btnFold, self._onClickBtnFold, self)
end

function OriginAlchemyMengMengFmtView:buildUI()
	OriginAlchemyMengMengFmtView.super.buildUI(self)

	self._mask = self:getGo("mask")
	self._btnFold = self:getGo("mask/root/btnFold")
	self._imgFold = self:getGo("mask/root/btnFold/imgFold")
	self._fmt = self:getGo("mask/root/stageFmt/fmt")
	self._btnUse = self:getGo("btnUse")
	self._imgUse = self:getGo("btnUse/img")
	self._imgChange = self:getGo("btnUse/imgChange")
	self._content = self:getGo("content")
end

function OriginAlchemyMengMengFmtView:onExit()
	OriginAlchemyMengMengFmtView.super.onExit(self)
	self:_clearFmt(self._fmt)
	uGuiUtil.clearImage(self._imgChange)
end

function OriginAlchemyMengMengFmtView:onEnter()
	OriginAlchemyMengMengFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginAlchemyMengMengChangeReagentId, self._onChangeReagentId, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo:getActivityId()

	if checknumber(self._activityId) <= 0 then
		self._activityId = 601001
	end

	self._maskPosX = {
		-310.6,
		197
	}
	self._isMaskExpand = true
	self._curReagentId = 0
	self._stageCfg = self._fmtMo._stageCfg or {}
	self._markPosition = self._stageCfg.markPosition
	self._info = OriginalChemyMengMengModel.instance:getInfo(self._activityId) or {}
	self._gainReagent = checktable(self._info.gainReagent)
	self._hasUsedReagent = checktable(self._info.hasUsedReagent)
	self._reagentList = {}

	for i, reagentId in ipairs(self._gainReagent) do
		if not table.indexof(self._hasUsedReagent, reagentId) then
			table.insert(self._reagentList, reagentId)
		end
	end

	local preSelectId = OriginalChemyMengMengModel.instance:getSelectedReagentId(self._activityId)
	local hasPreSelect = table.indexof(self._reagentList, preSelectId)

	if hasPreSelect then
		self._curReagentId = preSelectId
	end

	if self._curReagentId > 0 then
		self:_onChangeReagentId(self._curReagentId)
		self._fmtMo:setUseReagentId(self._curReagentId)
	end

	GameUtil.SetActive(self._imgUse, not hasPreSelect)
	GameUtil.SetActive(self._imgChange, hasPreSelect)

	local maskLocalPos = GameUtil.getLocalPos(self._mask)

	self:_updateMaskState(false)
	self:_setFmt(self._fmt, self._fmtMo._creepsCfg)
end

function OriginAlchemyMengMengFmtView:_setFmt(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")
		local tag = goutil.findChild(go, "tag")
		local imgTag = goutil.findChild(go, "tag/img")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)
		GameUtil.SetActive(tag, checknumber(self._markPosition[posId]) > 0)

		if checknumber(self._markPosition[posId]) > 0 then
			local markCfg = OriginalChemyMengMengConfig.instance:getMarkCfg(self._activityId, self._markPosition[posId])

			uGuiUtil.setSpriteToImage(imgTag, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(markCfg.resName))
		end

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function OriginAlchemyMengMengFmtView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")
		local imgTag = goutil.findChild(go, "tag/img")

		MaterialMgr.clearIcon(con)
		uGuiUtil.clearImage(imgTag)
	end
end

function OriginAlchemyMengMengFmtView:_onClickBtnFold()
	self._isMaskExpand = not self._isMaskExpand

	self:_updateMaskState(true)
end

function OriginAlchemyMengMengFmtView:_onClickBtnUse()
	self:showTabAt(self._content, ViewName.OriginAlchemyMengMengSelectView, self._activityId, self._fmtMo)
end

function OriginAlchemyMengMengFmtView:_updateMaskState(withAnim)
	local targetIndex = self._isMaskExpand and 1 or 2

	if self._isMaskExpand then
		GameUtil.setLocalRotation(self._imgFold, 0, 0, 0)
	else
		GameUtil.setLocalRotation(self._imgFold, 0, 0, 180)
	end

	if not withAnim then
		GameUtil.setAnchoredPos(self._mask, self._maskPosX[targetIndex], 0)

		return
	end

	if self._isMaskExpand then
		UnityTweens.TweenPosition.StartTween(self._mask, Vector3.New(self._maskPosX[2], 0, 0), Vector3.New(self._maskPosX[1], 0, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
	else
		UnityTweens.TweenPosition.StartTween(self._mask, Vector3.New(self._maskPosX[1], 0, 0), Vector3.New(self._maskPosX[2], 0, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
	end
end

function OriginAlchemyMengMengFmtView:_onChangeReagentId(reagentId)
	local reagentCfg = OriginalChemyMengMengConfig.instance:getReagentCfg(self._activityId, reagentId)

	self._curReagentId = reagentId

	GameUtil.SetActive(self._imgUse, self._curReagentId <= 0)
	GameUtil.SetActive(self._imgChange, self._curReagentId > 0)
	uGuiUtil.setSpriteToImage(self._imgChange, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(reagentCfg.resName))
end

return OriginAlchemyMengMengFmtView
