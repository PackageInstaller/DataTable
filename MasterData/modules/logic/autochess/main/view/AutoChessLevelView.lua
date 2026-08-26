-- chunkname: @modules/logic/autochess/main/view/AutoChessLevelView.lua

module("modules.logic.autochess.main.view.AutoChessLevelView", package.seeall)

local AutoChessLevelView = class("AutoChessLevelView", BaseView)

function AutoChessLevelView:onInitView()
	self._goStageRoot = gohelper.findChild(self.viewGO, "#go_StageRoot")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessLevelView:_editableInitView()
	return
end

function AutoChessLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_copy_enter)

	self.levelItemDic = self:getUserDataTb_()

	local actId = Activity182Model.instance:getCurActId()
	local episodeCoList = AutoChessConfig.instance:getPveEpisodeCoList(actId)

	for i = 1, 6 do
		local co = episodeCoList[i]

		if co then
			local parent = gohelper.findChild(self._goStageRoot, "go_Stage" .. i)
			local go = self:getResInst(AutoChessStrEnum.ResPath.LevelItem, parent, "stage" .. i)
			local goArrow = gohelper.findChild(parent, "go_Arrow" .. i)
			local levelItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessLevelItem, self)

			levelItem.goArrow = goArrow

			levelItem:setData(co)

			local _, _, rotationZ = transformhelper.getLocalRotation(parent.transform)

			transformhelper.setLocalRotation(levelItem._goRewardTips.transform, 0, 0, -rotationZ)

			self.levelItemDic[co.id] = levelItem
		end
	end
end

function AutoChessLevelView:onClickItem(id)
	if self.openRewardId then
		local levelItem = self.levelItemDic[self.openRewardId]

		levelItem:closeReward()

		self.openRewardId = nil
	else
		local levelItem = self.levelItemDic[id]

		levelItem:enterLevel()
	end
end

function AutoChessLevelView:onOpenItemReward(id)
	if self.openRewardId then
		local levelItem = self.levelItemDic[self.openRewardId]

		levelItem:closeReward()

		self.openRewardId = nil
	else
		local levelItem = self.levelItemDic[id]

		levelItem:openReward()

		self.openRewardId = id
	end
end

function AutoChessLevelView:onCloseItemReward(id)
	local levelItem = self.levelItemDic[id]

	levelItem:closeReward()

	self.openRewardId = nil
end

function AutoChessLevelView:onGiveUpGame(id)
	if self.openRewardId then
		local levelItem = self.levelItemDic[self.openRewardId]

		levelItem:closeReward()

		self.openRewardId = nil
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
			AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE)
		end)
	end
end

return AutoChessLevelView
