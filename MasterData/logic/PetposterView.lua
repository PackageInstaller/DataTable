-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petposter/view/PetposterView.lua

module("logic.extensions.petposter.view.PetposterView", package.seeall)

local PetposterView = class("PetposterView", ViewComponent)

function PetposterView:ctor()
	PetposterView.super.ctor(self)
end

function PetposterView:buildUI()
	PetposterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._cellPoster = self:getGo("cell")
	self._tablePoster = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._tablePoster, self._cellPoster, GameUtil.handler(self._updateCellPoster, self), GameUtil.handler(self._clearCellPoster, self))
end

function PetposterView:bindEvents()
	PetposterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function PetposterView:unbindEvents()
	PetposterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PetposterView:destroyUI()
	PetposterView.super.destroyUI(self)
end

function PetposterView:onEnter()
	PetposterView.super.onEnter(self)
	HandbookController.instance:checkDataAndCall(self._updateView, self)
end

function PetposterView:onEnterFinished()
	PetposterView.super.onEnterFinished(self)
end

function PetposterView:onExit()
	PetposterView.super.onExit(self)
	self._tableView:dispose()
end

function PetposterView:onExitFinished()
	PetposterView.super.onExitFinished(self)
end

function PetposterView:_updateView()
	local curDataList = HandbookModel.instance:getPosterDataList()
	local dataList = {}

	for _, v in pairs(curDataList) do
		local tab = checkint(v.cfg.enterTab)
		local btnId = checkint(v.cfg.enterId)

		if tab > 0 and btnId > 0 then
			dataList[tab] = dataList[tab] or {}
			dataList[tab][btnId] = v
		end
	end

	self._tableView:reloadData(dataList)
end

function PetposterView:_clearCellPoster(cell)
	local posterList = {}

	for i = 1, 6 do
		local poster = {}
		local go = goutil.findChild(cell, "poster" .. i)

		poster.go = go

		uGuiUtil.clearImage(go)

		poster.btn = GameUtil.asBtn(go)

		poster.btn:RemoveClickListener()

		poster.txtNum = goutil.findChildTextComponent(go, "txtNum")
		poster.txtTotal = goutil.findChildTextComponent(go, "txtTotal")
		poster.dot = goutil.findChild(go, "dot")

		goutil.setActive(poster.dot, false)

		posterList[i] = poster
	end

	return posterList
end

function PetposterView:_updateCellPoster(view, cell, data)
	local posterList = self:_clearCellPoster(cell)

	for i = 1, 6 do
		if data[i] then
			local cfg = data[i].cfg
			local info = data[i].info
			local hasCollect = data[i].hasCollect

			goutil.setActive(posterList[i].go, true)
			uGuiUtil.setSpriteToImage(posterList[i].go, uGuiUtil.SpriteType.BigBg, GameUrl.getPetPosterBigbgPngUrl(cfg.enterPoster))

			if info and info.petListHasGain then
				if not #info.petListHasGain then
					local hasGainPetNum = 0

					if not #hasCollect then
						local hasCollectPetNum = 0

						posterList[i].txtNum.text = hasGainPetNum

						if cfg.needRaceIds then
							if not #cfg.needRaceIds then
								local totalGainPetNum = 1

								posterList[i].txtTotal.text = totalGainPetNum

								posterList[i].btn:AddClickListener(function()
									self:_onClickPoster(data[i])
								end, self)

								local isShowDot = not info.isGainTeamPrize and hasGainPetNum == totalGainPetNum or hasGainPetNum < hasCollectPetNum

								goutil.setActive(posterList[i].dot, isShowDot)
							end
						end
					end
				end
			end
		else
			goutil.setActive(posterList[i].go, false)
		end
	end
end

function PetposterView:_onClickPoster(data)
	UIStateManager.instance:push(ViewName.PetpostershowView, data.cfg.teamId)
end

return PetposterView
