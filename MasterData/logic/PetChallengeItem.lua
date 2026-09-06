-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/PetChallengeItem.lua

module("logic.extensions.legend.view.PetChallengeItem", package.seeall)

local PetChallengeItem = class("PetChallengeItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function PetChallengeItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, PetChallengeItem)

	component = component or LuaComponentContainer.Add(go, PetChallengeItem)

	return component
end

function PetChallengeItem:ctor(luaComponentContainer)
	local parentGo = luaComponentContainer.gameObject

	self._imgBgChange = goutil.findChild(parentGo, "imgBg"):GetComponent("UIImageSpriteChange")
	self._imgBg2Change = goutil.findChild(parentGo, "imgBg2"):GetComponent("UIImageSpriteChange")
	self._imgIcon = goutil.findChild(parentGo, "imgIcon/con")
	self._txtName = goutil.findChildTextComponent(parentGo, "txtName")
	self._rarePoint = goutil.findChild(parentGo, "rarePoint")
	self._btnLock = Framework.ButtonAdapter.GetFrom(parentGo, "btnLock")
	self._txtLock = goutil.findChildTextComponent(parentGo, "btnLock/txtLock")
	self._sweepTxt = goutil.findChild(parentGo, "sweepTxt")
	self._txtSweepCount = goutil.findChildTextComponent(parentGo, "sweepTxt/txtSweepCount")
	self._btnSweep = Framework.ButtonAdapter.GetFrom(parentGo, "btnSweep")
	self._btnChallenge = Framework.ButtonAdapter.GetFrom(parentGo, "btnChallenge")
end

function PetChallengeItem:_onClickBtnLock()
	if not string.nilorempty(self._desc) then
		FloatWordMgr.instance:show(self._desc)
	end
end

function PetChallengeItem:_onClickBtnSweep()
	local cfgList = LegendConfig.instance:getLegendChallengeStageCfgList(self._cfg.challengeId)

	if cfgList and #cfgList > 0 then
		MopupModel.instance:clickLegenSweep(self._cfg.challengeId, cfgList[#cfgList].stageId)
	end
end

function PetChallengeItem:_onClickBtnChallenge()
	local challengeCfg = LegendConfig.instance:getLegendChallengeCfg(self._cfg.challengeId)

	if challengeCfg then
		GotoMgr.gotoByString(challengeCfg.jumpTo)
	end
end

function PetChallengeItem:init(data)
	self._cfg = data.cfg

	self._btnLock:AddClickListener(self._onClickBtnLock, self)
	self._btnSweep:AddClickListener(self._onClickBtnSweep, self)
	self._btnChallenge:AddClickListener(self._onClickBtnChallenge, self)

	local funcOpenCfg = FuncOpenConfig.instance:getFunctionOpenById(self._cfg.unlockId)

	if funcOpenCfg then
		self._desc = funcOpenCfg.description or ""
	end

	local isUnlock = false

	isUnlock = self._cfg.unlockId > 0 and FuncOpenModel.instance:getFuncIsOpen(self._cfg.unlockId) or true

	local isPass = LegendModel.instance:isChallengePass(self._cfg.challengeId)

	goutil.setActive(self._btnLock.gameObject, not isUnlock)
	goutil.setActive(self._btnSweep.gameObject, isUnlock and isPass)
	goutil.setActive(self._btnChallenge.gameObject, isUnlock and not isPass)
	goutil.setActive(self._sweepTxt, isUnlock and isPass)

	self._txtName.text = self._cfg.challengeName
	self._txtLock.text = self._desc
	self._txtSweepCount.text = self:_getSweepCountTxt()

	local rareNum = CharacterConfig.instance:getInitRare(self._cfg.raceId)

	self._imgBgChange:SetState(rareNum - 1)
	self._imgBg2Change:SetState(rareNum - 1)
	MaterialMgr.resetAll(self._rarePoint)
	MaterialMgr.setCell(MatType.Rare, self._cfg.raceId, self._rarePoint)

	local cfgModel = CharacterConfig.instance:getModelCo(self._cfg.raceId)

	if cfgModel then
		uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/pet/%s.png", cfgModel.cardName))
	end
end

function PetChallengeItem:reset()
	self._btnLock:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	MaterialMgr.resetAll(self._rarePoint)

	local img = Framework.ImageBigBG.Get(self._imgIcon)

	if img then
		img:ClearImage()
	end
end

function PetChallengeItem:_getSweepCountTxt()
	local curCount = LegendModel.instance:getLeftCountByChallengeId(self._cfg.challengeId)

	return string.format("%d/%d", checknumber(curCount), checknumber(self._cfg.dailyTimes))
end

return PetChallengeItem
