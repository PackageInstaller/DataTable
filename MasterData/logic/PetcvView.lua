-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcv/view/PetcvView.lua

module("logic.extensions.petcv.view.PetcvView", package.seeall)

local PetcvView = class("PetcvView", TableViewComponent)

function PetcvView:ctor()
	PetcvView.super.ctor(self)
end

function PetcvView:buildUI()
	PetcvView.super.buildUI(self)

	self._bubble = self:getGo("bubble")
	self._tips = self:getGo("tips")
end

function PetcvView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PetcvView:bindEvents()
	PetcvView.super.bindEvents(self)
end

function PetcvView:unbindEvents()
	PetcvView.super.unbindEvents(self)
end

function PetcvView:destroyUI()
	PetcvView.super.destroyUI(self)
end

function PetcvView:onEnter()
	PetcvView.super.onEnter(self)

	local raceId = self:getFirstParam()

	self.raceId = raceId and raceId or PetbookModel.instance:getSelectedPetId()
	self._curViewDatas = CharacterConfig.instance:getPetCvCfg(self.raceId)

	self._tableview:SetOffset(0)

	if not PetCvModel.instance:getHasLoadData() then
		GlobalDispatcher:addListener(GoodFeelController.PM_GFGetRaceBookInfoRes, self._refreshAll, self)
		GoodFeelingAgent.instance:sendPM_GFGetRaceBookInfoReq()
		PetCvModel.instance:setHasLoadData(true)
	else
		self:_refreshAll()
	end

	goutil.setActive(self._tips, not self._curViewDatas or #self._curViewDatas <= 0)
end

function PetcvView:onEnterFinished()
	PetcvView.super.onEnterFinished(self)
end

function PetcvView:onExit()
	PetcvView.super.onExit(self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFGetRaceBookInfoRes, self._refreshAll, self)
end

function PetcvView:onExitFinished()
	PetcvView.super.onExitFinished(self)
end

function PetcvView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goPLayCv = goutil.findChild(cell, "btnVoice")
	local btnPlayCv = Framework.ButtonAdapter.Get(goPLayCv)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.raceId)
	local raceId = skinCfg.raceId
	local lv = GoodFeelModel.instance:getPetGoodFeelLv(raceId)
	local lockStr = lv < data.goodfeelUnlockLv and string.format("好感度%s级解锁", data.goodfeelUnlockLv)

	txtName.text = lockStr or data.usageScenarios

	btnPlayCv:AddClickListener(function()
		self:_playCv(self.raceId, cell.index + 1, lockStr)
	end)
end

function PetcvView:_playCv(raceId, index, lockStr)
	if lockStr then
		FloatWordMgr.instance:show(lockStr)

		return
	end

	local pos = self._bubble.transform.position

	PetCvController.instance:_playPetCvByIndex(raceId, index, true, pos)
end

function PetcvView:_refreshAll()
	self:reloadData()
end

return PetcvView
