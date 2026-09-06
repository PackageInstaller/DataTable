-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestWinGroupView.lua

module("logic.extensions.goddesscontest.view.GoddessContestWinGroupView", package.seeall)

local GoddessContestWinGroupView = class("GoddessContestWinGroupView", ViewComponent)

function GoddessContestWinGroupView:buildUI()
	GoddessContestWinGroupView.super.buildUI(self)

	self._btnEnter = self:getGo("info/btnEnter")
	self._comLayout = self:getGo("goddess/comLayout")
	self._goddessCell = self:getGo("goddess/cell")

	goutil.setActive(self._goddessCell, false)

	self._iconGroup = self:getGo("info/group/icon"):GetComponent("UIImageSpriteChange")
	self._txtNameGroup = self:getTxt("info/group/txtName")
	self._txtTitleGroup = self:getTxt("info/group/txtTitle")
	self._iconGoddess = self:getGo("info/pet/headIcon")
	self._txtNameGoddess = self:getTxt("info/pet/txtName")
	self._txtDesc = self:getTxt("info/pet/txtDesc")
end

function GoddessContestWinGroupView:bindEvents()
	GoddessContestWinGroupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
end

function GoddessContestWinGroupView:unbindEvents()
	GoddessContestWinGroupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnEnter)
end

function GoddessContestWinGroupView:onEnter()
	GoddessContestWinGroupView.super.onEnter(self)

	self._winGroupInfo = GoddessContestModel.instance:getWinGroupInfo()
	self._winGoddessInfo = GoddessContestModel.instance:getWinGoddessInfo()
	self._curActId = GoddessContestModel.instance:getCurActId()
	self._groupCfg = GoddessContestConfig.instance:getFanGroupCfgsByActIdAndGroupId(self._curActId, self._winGroupInfo.groupData.groupId)
	self._txtDesc.text = GoddessContestConfig.instance:getCommondValueByKey("WINNER_DESC_1")

	self:_refreshView()
end

function GoddessContestWinGroupView:onExit()
	GoddessContestWinGroupView.super.onExit(self)

	for _, v in ipairs(self._cellList) do
		uGuiUtil.clearImage(v.iconSkin)
	end
end

function GoddessContestWinGroupView:_onClickEnter()
	if GoddessContestModel.instance:getCurFansGroupInfo() then
		UIStateManager.instance:push(ViewName.GoddessContestGroupView)
	else
		FloatWordMgr.instance:show("本次活动已结束，您没有加入粉丝团。")
	end
end

function GoddessContestWinGroupView:_refreshView()
	self._cellList = {}

	if self._groupCfg then
		if not self._groupCfg.fansGroupGoddess then
			local skinIds = {}

			for id, skinId in ipairs(skinIds) do
				self._cellList[id] = self:_refreshCell(id, skinId)
			end

			self._iconGroup:SetState(self._groupCfg.fansGroupId - 1)

			self._txtNameGroup.text = self._groupCfg.fansGroupName
			self._txtTitleGroup.text = self._groupCfg.fansGroupName

			MaterialMgr.setIcon(self._iconGoddess, MatType.PET_SKIN, self._winGoddessInfo.faceId)

			self._txtNameGoddess.text = PetSkinConfig.instance:getPetSkinName(self._winGoddessInfo.faceId)
		end
	end
end

function GoddessContestWinGroupView:_refreshCell(id, skinId)
	local cell = {}

	cell.go = goutil.findChild(self._comLayout, "cell_" .. id) or goutil.cloneAndSetParent(self._goddessCell, self._comLayout.transform, "cell_" .. id)
	cell.skinId = skinId
	cell.txtName = goutil.findChildTextComponent(cell.go, "name/txt")
	cell.tagWin = goutil.findChild(cell.go, "tagWin")
	cell.iconSkin = goutil.findChild(cell.go, "pet/icon")

	uGuiUtil.clearImage(cell.iconSkin)

	local faceId = checknumber(skinId)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(cell.iconSkin, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	cell.txtName.text = PetSkinConfig.instance:getPetSkinName(faceId)

	goutil.setActive(cell.go, true)
	goutil.setActive(cell.tagWin, skinId == checkint(self._winGoddessInfo and self._winGoddessInfo.faceId))
	GameUtil.rmClickHandler(cell.iconSkin)
	GameUtil.addClickHandler(cell.iconSkin, GameUtil.handler(self._onClickCheck, self, faceId))

	return cell
end

function GoddessContestWinGroupView:_onClickCheck(faceId)
	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, faceId)
end

return GoddessContestWinGroupView
