-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroLevelUpView.lua

module("logic.extensions.miraclehero.view.MiracleHeroLevelUpView", package.seeall)

local MiracleHeroLevelUpView = class("MiracleHeroLevelUpView", ViewComponent)

function MiracleHeroLevelUpView:ctor()
	MiracleHeroLevelUpView.super.ctor(self)
end

function MiracleHeroLevelUpView:unbindEvents()
	MiracleHeroLevelUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnRightArrow)
	GameUtil.rmClickHandler(self._btnLeftArrow)
end

function MiracleHeroLevelUpView:bindEvents()
	MiracleHeroLevelUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._btnRightArrow, self._onClickRightArrowBtn, self)
	GameUtil.addClickHandler(self._btnLeftArrow, self._onClickLeftArrowBtn, self)
end

function MiracleHeroLevelUpView:buildUI()
	MiracleHeroLevelUpView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._role = self:getGo("rolecon/role")
	self._txtCurPos = self:getTxt("curPos/txt")
	self._levelUp = self:getGo("levelUp")
	self._btnLevelUp = self:getGo("levelUp/btnLevelUp")
	self._iconCost = self:getGo("levelUp/cost/icon")
	self._matCell = self:getGo("levelUp/cost/matCell")
	self._txtNumCost = self:getTxt("levelUp/cost/txtNum")
	self._partCur = self:_buildAttrPart(self:getGo("levelUp/cur"))
	self._partNext = self:_buildAttrPart(self:getGo("levelUp/next"))
	self._partMax = self:_buildAttrPart(self:getGo("lvMax"))
	self._btnRightArrow = self:getGo("Btn_RightArrow")
	self._btnLeftArrow = self:getGo("Btn_LeftArrow")
end

function MiracleHeroLevelUpView:_buildAttrPart(go)
	if go then
		local cell = {}

		cell.go = go
		cell.txtLv = goutil.findChildTextComponent(cell.go, "lv/txt")
		cell.txtHp = goutil.findChildTextComponent(cell.go, "hp/txt")
		cell.txtAtk = goutil.findChildTextComponent(cell.go, "atk/txt")
		cell.txtSpe = goutil.findChildTextComponent(cell.go, "spe/txt")
		cell.txtCri = goutil.findChildTextComponent(cell.go, "cri/txt")

		return cell
	end
end

function MiracleHeroLevelUpView:onExit()
	MiracleHeroLevelUpView.super.onExit(self)
	uGuiUtil.clearImage(self._role)
	MaterialMgr.resetAll(self._iconCost)
end

function MiracleHeroLevelUpView:onEnter()
	MiracleHeroLevelUpView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._infoList = params[2]
	self._posInfo = params[3]
	self._curPosId = self._posInfo.posId

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self.addGEvent(self, GlobalNotify.MiracleHeroUpgradePositionRes, self._handleLevelUp, self)
end

function MiracleHeroLevelUpView:_onClickLevelUp()
	local isEnough = MaterialMgr.getMatEnough(self._curCostStr)

	if not isEnough then
		local costType, costId, costNum = MaterialMgr.getMatParams(self._curCostStr)

		FloatWordMgr.instance:show(langPara("%s数量不足", MaterialMgr.getMaterialsName(costType, costId)))

		return
	end

	MiracleHeroController.instance:sendPM_MiracleHeroUpgradePositionReq(self._activityId, self._posInfo.posId)
end

function MiracleHeroLevelUpView:_onClickLeftArrowBtn()
	if self._curPosId - 1 > 0 then
		self._curPosId = self._curPosId - 1 or 1
	end

	self._posInfo = self._infoList[self._curPosId]

	self:_updateUIByInfo()
end

function MiracleHeroLevelUpView:_onClickRightArrowBtn()
	if self._curPosId + 1 <= #self._infoList then
		self._curPosId = self._curPosId + 1 or #self._infoList
	end

	self._posInfo = self._infoList[self._curPosId]

	self:_updateUIByInfo()
end

function MiracleHeroLevelUpView:_updateUIByCfg()
	self._actCfg = MiracleHeroConfig.instance:getActCfg(self._activityId)
	self._positUpgradeCfgs = MiracleHeroConfig.instance:getPositUpgradeCfgs(self._activityId)
end

function MiracleHeroLevelUpView:_updateUIByInfo()
	if self._posInfo then
		local raceId = self._posInfo.curRace
		local curLv = self._posInfo.level
		local posId = self._posInfo.posId
		local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, raceId)
		local faceId = checknumber(petCfg.faceIds)
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(faceId)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

		uGuiUtil.setSpriteToImage(self._role, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName), function()
			self._role:GetComponent("Image"):SetNativeSize()

			self._role:GetComponent("Image").raycastTarget = false
		end)

		self._txtCurPos.text = string.format("%s号阵位", posId)

		local isLvMax = curLv >= #self._positUpgradeCfgs

		goutil.setActive(self._partMax.go, isLvMax)
		goutil.setActive(self._levelUp, not isLvMax)

		self._propertyCfgs = MiracleHeroConfig.instance:getPropertyCfgs(petCfg.propertyStrategyId)

		if isLvMax then
			self:_setDataToPart(curLv, self._partMax)

			self._partMax.txtLv.text = lang("已满级")
		else
			self:_setDataToPart(curLv + 1, self._partNext)
			self:_setDataToPart(curLv, self._partCur)

			self._curCostStr = self._positUpgradeCfgs[curLv + 1].cost

			local costType, costId, costNum = MaterialMgr.getMatParams(self._curCostStr)

			MaterialMgr.setCell(costType, costId, self._matCell)

			local curHaveMatNum = MaterialModel.instance:getMaterialsNumber(costType, costId)

			self._txtNumCost.text = string.format("%s/%s", curHaveMatNum, costNum)
		end

		if posId == 1 then
			goutil.setActive(self._btnLeftArrow, false)
			goutil.setActive(self._btnRightArrow, true)
		elseif posId == #self._infoList then
			goutil.setActive(self._btnLeftArrow, true)
			goutil.setActive(self._btnRightArrow, false)
		else
			goutil.setActive(self._btnLeftArrow, true)
			goutil.setActive(self._btnRightArrow, true)
		end
	end
end

function MiracleHeroLevelUpView:_setDataToPart(lv, cell)
	local cfg = self._propertyCfgs[lv]

	cell.txtLv.text = langPara("%s级", MiracleHeroConfig.instance:getShowLevel(self._activityId, lv))
	cell.txtHp.text = cfg.hp
	cell.txtAtk.text = cfg.Atk
	cell.txtSpe.text = cfg.speed
	cell.txtCri.text = cfg.criticalRate
end

function MiracleHeroLevelUpView:_handleLevelUp()
	FloatWordMgr.instance:show("升级成功")
	self:_updateUIByInfo()
end

return MiracleHeroLevelUpView
