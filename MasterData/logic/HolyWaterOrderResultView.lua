-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderResultView.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderResultView", package.seeall)

local HolyWaterOrderResultView = class("HolyWaterOrderResultView", ViewComponent)

function HolyWaterOrderResultView:ctor()
	HolyWaterOrderResultView.super.ctor(self)
end

function HolyWaterOrderResultView:buildUI()
	HolyWaterOrderResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._itemCell = self:getGo("itemCol/itemCell")

	goutil.setActive(self._itemCell, false)

	self._itemView = self:getGo("itemCol/itemView")
	self._itemCellList = {}
	self._txtTip = self:getTxt("txtTip")
	self._starLists = {}

	for i = 1, 5 do
		self._starLists[i] = self:getGo("star" .. i .. "/img")
	end
end

function HolyWaterOrderResultView:bindEvents()
	HolyWaterOrderResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function HolyWaterOrderResultView:unbindEvents()
	HolyWaterOrderResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function HolyWaterOrderResultView:onEnter()
	HolyWaterOrderResultView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._stageId = HolyWaterOrderModel.instance:getBattleResultStageId()

	self:_closeAllItems()
	self:_initPetInfos()
	self:_initTip()
	self:_updateStars()
end

function HolyWaterOrderResultView:onExit()
	HolyWaterOrderResultView.super.onExit(self)
	self:_closeAllItems()
end

function HolyWaterOrderResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

function HolyWaterOrderResultView:_onClickSure()
	local randomNumber = HolyWaterOrderModel.instance:getRandomNumber()

	HolyWaterOrderAgent.instance:sendPM_HolyWaterOrderConfirmRecordReq(randomNumber)
	self:close()
	BattleController.instance:endBattle()
end

function HolyWaterOrderResultView:_initPetInfos()
	local petList = HolyWaterOrderModel.instance:getBattleResultPetInfos()

	for i, v in ipairs(petList) do
		local cell = self._itemCellList[i] and self._itemCellList[i] or self:_createCell(i)

		goutil.setActive(cell.go, true)

		local petMo = BagPetsController.instance:getPet(v.petId)

		if petMo then
			local percent = Mathf.Clamp01(v.hp / petMo._maxHp) * 100

			if percent > 0 and percent <= 1 then
				percent = 1
			end

			if percent >= 30 then
				if not ColorConst.Green2 then
					local colorStr = ColorConst.Red

					cell.txtNum.text = string.format("<color=#%s>%d%%</color>", colorStr, percent)

					local proxy = MaterialMgr.setCellByMo(petMo, cell.item)

					proxy.binder:setClickCallBack(function(petCell)
						if cell and cell.item then
							CommonTipsMgr.instance:openMaterialTips(cell.item, MatType.Pet, petMo:getPetId())
						end
					end)
				end
			end
		end
	end
end

function HolyWaterOrderResultView:_createCell(index)
	local go = goutil.cloneAndSetParent(self._itemCell, self._itemView.transform, "item" .. index)
	local cell = {}

	cell.go = go
	cell.txtNum = goutil.findChildTextComponent(go, "txtNum")
	cell.item = goutil.findChild(go, "item")
	self._itemCellList[index] = cell

	return cell
end

function HolyWaterOrderResultView:_closeAllItems()
	for i, v in ipairs(self._itemCellList) do
		goutil.setActive(v.go, false)
		MaterialMgr.resetAll(v.item)
	end
end

function HolyWaterOrderResultView:_initTip()
	local cfgStage = HolyWaterOrderConfig.instance:getStageCfg(self._activityId, self._stageId)

	if cfgStage then
		local monsterCfg = HolyWaterOrderConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)

		self._txtTip.text = string.format("恭喜你成功击破%s，当前精灵存活情况如下：", monsterCfg.name)
	end
end

function HolyWaterOrderResultView:_updateStars()
	local starNum = HolyWaterOrderModel.instance:getBattleResultStars()

	for i = 1, 5 do
		if self._starLists[i] then
			goutil.setActive(self._starLists[i], i <= starNum)
		end
	end
end

return HolyWaterOrderResultView
