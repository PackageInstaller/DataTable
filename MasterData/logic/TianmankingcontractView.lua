-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingcontractView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmankingcontractView", package.seeall)

local TianmankingcontractView = class("TianmankingcontractView", ViewComponent)

function TianmankingcontractView:unbindEvents()
	TianmankingcontractView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for i, v in ipairs(self._contract) do
		v.selectBtn:RemoveClickListener()
		v.tipBtn:RemoveClickListener()
	end
end

function TianmankingcontractView:bindEvents()
	TianmankingcontractView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i, v in ipairs(self._contract) do
		v.selectBtn:AddClickListener(function()
			self:_onClickPet(i)
		end)
		v.tipBtn:AddClickListener(function()
			self:_onClickTip(i)
		end)
	end
end

function TianmankingcontractView:buildUI()
	TianmankingcontractView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._contract = {}

	local contract = self:getGo("contract")

	for i = 1, 4 do
		local path = "pet_" .. i

		self._contract[i] = {
			selectBtn = Framework.ButtonAdapter.GetFrom(contract, path .. "/selectBtn")
		}
		self._contract[i].name = goutil.findChildTextComponent(contract, path .. "/name")
		self._contract[i].desc = goutil.findChildTextComponent(contract, path .. "/desc")
		self._contract[i].tipBtn = Framework.ButtonAdapter.GetFrom(contract, path .. "/tipBtn")
		self._contract[i].useFlag = goutil.findChild(contract, path .. "/useFlag")
		self._contract[i].lock = goutil.findChild(contract, path .. "/lock")
		self._contract[i].lockText = goutil.findChildTextComponent(contract, path .. "/lock/txtLock")
		self._contract[i].con = goutil.findChild(contract, path .. "/pet/con")
	end
end

function TianmankingcontractView:onExit()
	TianmankingcontractView.super.onExit(self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCSelectSummonRes, self.close, self)
end

function TianmankingcontractView:onEnter()
	TianmankingcontractView.super.onEnter(self)

	self._timeOpenPassedStage = TianmanKingModel.instance:getTimeOpenPassedStage()

	local supportPetCfg = TianmanKingConfig.instance:getSupportPet()

	for i, cell in ipairs(self._contract) do
		local petCo = CharacterConfig.instance:getPetCo(supportPetCfg[i + 1].raceId)

		cell.name.text = petCo.name

		uGuiUtil.setGoGrayState(cell.name.gameObject, not self._timeOpenPassedStage[i])
		uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.SpriteType.BigBg, GameUrl.getLotteryPetImgUrl(petCo.raceId))
		uGuiUtil.setGoGrayState(cell.con, not self._timeOpenPassedStage[i])

		local stageCfg = TianmanKingConfig.instance:getStageByTypeAndStage(1, i)
		local opTime = GameUtil.string2time(stageCfg.unlockParams)

		goutil.setActive(cell.lock, not self._timeOpenPassedStage[i])

		if opTime > ServerTime.now() then
			cell.lockText.text = TianmanKingController.instance:getText("TEXT_11", os.date("%m月%d日 %H:%M:%S", opTime))

			goutil.setActive(cell.selectBtn.gameObject, false)
		else
			goutil.setActive(cell.selectBtn.gameObject, self._timeOpenPassedStage[i] and TianmanKingModel.instance:getCurSummon() ~= supportPetCfg[i + 1].supportPetId)
		end

		cell.desc.text = supportPetCfg[i + 1].desc

		goutil.setActive(cell.useFlag, TianmanKingModel.instance:getCurSummon() == supportPetCfg[i + 1].supportPetId)
	end

	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCSelectSummonRes, self.close, self)
end

function TianmankingcontractView:_onClickPet(index)
	local supportPetCfg = TianmanKingConfig.instance:getSupportPet()

	TianmanKingController.instance:sendPM_TMWCSelectSummonReq(supportPetCfg[index + 1].supportPetId)
end

function TianmankingcontractView:_onClickTip(index)
	local supportPetCfg = TianmanKingConfig.instance:getSupportPet()

	CommonTipsMgr.instance:showMaxLvlPetTips(supportPetCfg[index + 1].raceId)
end

return TianmankingcontractView
