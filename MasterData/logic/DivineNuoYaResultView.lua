-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaResultView.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaResultView", package.seeall)

local DivineNuoYaResultView = class("DivineNuoYaResultView", ViewComponent)

function DivineNuoYaResultView:ctor()
	DivineNuoYaResultView.super.ctor(self)
end

function DivineNuoYaResultView:buildUI()
	DivineNuoYaResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._itemCell = self:getGo("itemCol/itemCell")

	goutil.setActive(self._itemCell, false)

	self._itemView = self:getGo("itemCol/itemView")
	self._itemCellList = {}
	self._txtTip = self:getTxt("txtTip")
end

function DivineNuoYaResultView:bindEvents()
	DivineNuoYaResultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function DivineNuoYaResultView:unbindEvents()
	DivineNuoYaResultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function DivineNuoYaResultView:onEnter()
	DivineNuoYaResultView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._bigStageId = DivineNuoYaChallengeModel.instance:getBattleExtremeBigStageId()
	self._smallStageId = DivineNuoYaChallengeModel.instance:getBattleExtremeSmallStageId()

	self:_closeAllItems()
	self:_initPetInfos()
	self:_initTip()
end

function DivineNuoYaResultView:onExit()
	DivineNuoYaResultView.super.onExit(self)
	self:_closeAllItems()
end

function DivineNuoYaResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

function DivineNuoYaResultView:_onClickSure()
	self:_onClickClose()
end

function DivineNuoYaResultView:_initPetInfos()
	local petList = DivineNuoYaChallengeModel.instance:getBattleResultPetInfos()

	for i, v in ipairs(petList) do
		local cell = self._itemCellList[i] and self._itemCellList[i] or self:_createCell(i)

		goutil.setActive(cell.go, true)

		local petMo = BagPetsController.instance:getPet(v.petId)

		if petMo then
			if v.leftHp == -1 then
				if not petMo._maxHp then
					local leftHp = v.leftHp
					local percent = Mathf.Clamp01(leftHp / petMo._maxHp) * 100

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
	end
end

function DivineNuoYaResultView:_createCell(index)
	local go = goutil.cloneAndSetParent(self._itemCell, self._itemView.transform, "item" .. index)
	local cell = {}

	cell.go = go
	cell.txtNum = goutil.findChildTextComponent(go, "txtNum")
	cell.item = goutil.findChild(go, "item")
	self._itemCellList[index] = cell

	return cell
end

function DivineNuoYaResultView:_closeAllItems()
	for i, v in ipairs(self._itemCellList) do
		goutil.setActive(v.go, false)
		MaterialMgr.resetAll(v.item)
	end
end

function DivineNuoYaResultView:_initTip()
	local cfgStage = DivineNuoYaChallengeConfig.instance:getMonster(self._activityId, self._bigStageId, self._smallStageId)

	if cfgStage then
		local monsterCfg = DivineNuoYaChallengeConfig.instance:getMaster(cfgStage.creepsMasterId)

		self._txtTip.text = string.format("恭喜你成功击破%s，当前精灵存活情况如下：", monsterCfg.name)
	end
end

return DivineNuoYaResultView
