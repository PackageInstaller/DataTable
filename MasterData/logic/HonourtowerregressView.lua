-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/view/HonourtowerregressView.lua

module("logic.extensions.honourtower.view.HonourtowerregressView", package.seeall)

local HonourtowerregressView = class("HonourtowerregressView", ViewComponent)

function HonourtowerregressView:ctor()
	HonourtowerregressView.super.ctor(self)
end

function HonourtowerregressView:unbindEvents()
	HonourtowerregressView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function HonourtowerregressView:bindEvents()
	HonourtowerregressView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickbtnOk, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function HonourtowerregressView:buildUI()
	HonourtowerregressView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._cellGo = self:getGo("cell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnOk = self:getBtn("btnOk")
	self._btnClose = self:getBtn("btnClose")
end

function HonourtowerregressView:onExit()
	HonourtowerregressView.super.onExit(self)
	self._scrollerList:dispose()
end

function HonourtowerregressView:onEnter()
	HonourtowerregressView.super.onEnter(self)

	self._periodId = HonourTowerModel.instance:getPeriodId()
	self._challengeId = 0
	self._maxStageIds = HonourTowerModel.instance:getMaxStageIds()

	local ids = HonourTowerConfig.instance:getRegressChallengeIds(self._periodId)
	local isSelectIds = HonourTowerModel.instance:getRegressChallengeIds()
	local isSelectIdsKV = {}

	for i, v in ipairs(isSelectIds) do
		isSelectIdsKV[v] = true
	end

	for i = #ids, 1, -1 do
		if isSelectIdsKV[ids[i]] then
			table.remove(ids, i)
		end
	end

	local norList = {}
	local finishList = {}

	for i, challengeId in ipairs(ids) do
		local cnt = #HonourTowerConfig.instance:getStageCfgs(challengeId)

		if not self._maxStageIds[challengeId] then
			if cnt <= self._maxStageIds[challengeId] then
				table.insert(finishList, challengeId)
			else
				table.insert(norList, challengeId)
			end
		end
	end

	table.sort(norList, function(a, b)
		return (self._maxStageIds[b] or 0) < (self._maxStageIds[a] or 0)
	end)
	table.insertto(norList, finishList)
	self._scrollerList:reloadData(norList)
end

function HonourtowerregressView:_updateCell(view, cell, challengeId, tag)
	local cfg = HonourTowerConfig.instance:getChallengeCfg(challengeId)
	local bg = cell.gameObject
	local con = goutil.findChild(cell, "mask/con")
	local txtProgress = goutil.findChildTextComponent(cell, "cover/txtProgress")
	local Nego_Attr = goutil.findChild(cell, "cover/layout/Nego_Attr")
	local Img_attr = goutil.findChild(cell, "cover/layout/Nego_Attr/Img_attr")
	local txtName = goutil.findChildTextComponent(cell, "name/txtName")
	local selectGo = goutil.findChild(cell, "select")
	local gainFirstGo = goutil.findChild(cell, "gainFirst")
	local progressStr = ""
	local isPass = false

	if isPass then
		progressStr = "已通关"
	else
		local cnt = #HonourTowerConfig.instance:getStageCfgs(challengeId)

		if not self._maxStageIds[challengeId] then
			local passNum = 0

			progressStr = string.format("%s/%s", passNum, cnt)
		end
	end

	txtName.text = cfg.name
	txtProgress.text = progressStr

	local skinId = cfg.skinId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)
	GameUtil.rmClickHandler(bg)
	GameUtil.addClickHandler(bg, function()
		self:_setChallengeId(challengeId)
	end)

	if self._challengeId == 0 then
		self:_setChallengeId(challengeId)
	end

	goutil.setActive(selectGo, self._challengeId == challengeId)
	goutil.setActive(gainFirstGo, HonourTowerModel.instance:isChallengeGainAllFirstPrize(challengeId))
end

function HonourtowerregressView:_clearCell(cell)
	local con = goutil.findChild(cell, "mask/con")

	uGuiUtil.clearImage(con)

	local bg = cell.gameObject

	GameUtil.rmClickHandler(bg)
end

function HonourtowerregressView:_setChallengeId(challengeId)
	self._challengeId = challengeId

	self._scrollerList:refresh()
end

function HonourtowerregressView:_onClickbtnOk()
	if self._challengeId > 0 then
		local challengeCfg = HonourTowerConfig.instance:getChallengeCfg(self._challengeId)
		local text = string.format("确定回归%s挑战吗？", challengeCfg.name)

		TipsFacade.instance:openPopupWindow("提示", text, function()
			HonorTowerAgent.instance:sendPM_HonorTowerSelectRecallChallengeReq(self._periodId, self._challengeId)
			self:close()
		end)
	end
end

function HonourtowerregressView:_onClickbtnClose()
	self:close()
end

return HonourtowerregressView
