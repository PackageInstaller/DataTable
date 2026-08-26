-- chunkname: @modules/logic/playercard/view/PlayerCardLayoutView.lua

module("modules.logic.playercard.view.PlayerCardLayoutView", package.seeall)

local PlayerCardLayoutView = class("PlayerCardLayoutView", BaseView)

function PlayerCardLayoutView:onInitView()
	self.goCard = gohelper.findChild(self.viewGO, "Card")
	self.goPlayerInfo = gohelper.findChild(self.goCard, "#go_playerinfo")
	self.goAssit = gohelper.findChild(self.goCard, "#go_assit")
	self.goChapter = gohelper.findChild(self.goCard, "#go_chapter")
	self.goCardGroup = gohelper.findChild(self.goCard, "#go_cardgroup")
	self.goAchievement = gohelper.findChild(self.goCard, "#go_achievement")

	self:loadRight()
	self:initRightLayout()

	self.btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self.animator = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function PlayerCardLayoutView:addEvents()
	self.addClickCb(self, self.btnConfirm, self.onClicConfirm, self)
end

function PlayerCardLayoutView:removeEvents()
	return
end

function PlayerCardLayoutView:playCloseAnim()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.CloseLayout)
	self.animator:Play("close", self.onCloseAnimDone, self)
end

function PlayerCardLayoutView:onCloseAnimDone()
	self:closeThis()
end

function PlayerCardLayoutView:onClicConfirm()
	local data = self.rightLayout:getLayoutData()
	local info = self:getCardInfo()

	if info then
		local settings = info:getSetting({
			[PlayerCardEnum.SettingKey.RightLayout] = data
		})

		PlayerCardRpc.instance:sendSetPlayerCardShowSettingRequest(settings)
	end

	self:playCloseAnim()
end

function PlayerCardLayoutView:initRightLayout()
	self.rightLayout = MonoHelper.addNoUpdateLuaComOnceToGo(self.goCard, PlayerCardLayout)

	local layoutList = {}

	table.insert(layoutList, self:getLayoutItem(self.goAssit, PlayerCardEnum.RightLayout.Assit))
	table.insert(layoutList, self:getLayoutItem(self.goChapter, PlayerCardEnum.RightLayout.Chapter))
	table.insert(layoutList, self:getLayoutItem(self.goCardGroup, PlayerCardEnum.RightLayout.CardGroup, PlayerCardLayoutItemCardGroup, self.cardGroupComp))
	table.insert(layoutList, self:getLayoutItem(self.goAchievement, PlayerCardEnum.RightLayout.Achievement))
	self.rightLayout:setLayoutList(layoutList)
end

function PlayerCardLayoutView:getLayoutItem(go, layoutKey, layoutComp, cardComp)
	local param = {}

	param.layoutKey = layoutKey
	param.viewRoot = self.viewGO
	param.layout = self.rightLayout
	param.cardComp = cardComp
	layoutComp = layoutComp or PlayerCardLayoutItem

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, layoutComp, param)
end

function PlayerCardLayoutView:refreshLayout(info)
	local layoutData = info:getLayoutData()

	self.rightLayout:setEditMode(true)
	self.rightLayout:setData(layoutData)
end

function PlayerCardLayoutView:loadRight()
	self.compList = {}

	local otherRes = self.viewContainer:getSetting().otherRes

	self:loadGO(self.goPlayerInfo, PlayerCardPlayerInfo, otherRes.infoview)
	self:loadGO(self.goAssit, PlayerCardAssit, otherRes.assitview)
	self:loadGO(self.goChapter, PlayerCardChapter, otherRes.chapterview)

	local achieveParam = {
		itemRes = self.viewContainer:getRes(otherRes.achieveitem)
	}

	self:loadGO(self.goAchievement, PlayerCardAchievement, otherRes.achieveview, achieveParam)

	local param = {
		itemRes = self.viewContainer:getRes(otherRes.carditem)
	}

	self.cardGroupComp = self:loadGO(self.goCardGroup, PlayerCardCardGroup, otherRes.groupview, param)
end

function PlayerCardLayoutView:loadGO(go, cls, resPath, param)
	local parent = gohelper.findChild(go, "card")
	local resGO = self:getResInst(resPath, parent or go)

	gohelper.setAsFirstSibling(resGO)

	param = param or {}
	param.compType = PlayerCardEnum.CompType.Layout

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(resGO, cls, param)

	table.insert(self.compList, comp)

	return comp
end

function PlayerCardLayoutView:onOpen()
	self:_updateParam()
	self:refreshView()
end

function PlayerCardLayoutView:onUpdateParam()
	self:_updateParam()
	self:refreshView()
end

function PlayerCardLayoutView:_updateParam()
	local param = self.viewParam

	self.userId = param.userId
end

function PlayerCardLayoutView:getCardInfo()
	return PlayerCardModel.instance:getCardInfo(self.userId)
end

function PlayerCardLayoutView:refreshView()
	local info = self:getCardInfo()

	self:refreshCompList(info)
	self:refreshLayout(info)
end

function PlayerCardLayoutView:refreshCompList(info)
	if not self.compList then
		return
	end

	for i, v in ipairs(self.compList) do
		v:refreshView(info)
	end
end

function PlayerCardLayoutView:onClose()
	return
end

return PlayerCardLayoutView
