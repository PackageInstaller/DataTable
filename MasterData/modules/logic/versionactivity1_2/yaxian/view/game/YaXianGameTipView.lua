-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameTipView.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipView", package.seeall)

local YaXianGameTipView = class("YaXianGameTipView", BaseView)

function YaXianGameTipView:onInitView()
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_block")
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/layout/top/title/#txt_title")
	self._txtrecommondlevel = gohelper.findChildText(self.viewGO, "rotate/desc_container/recommond/#txt_recommondlevel")
	self._txtinfo = gohelper.findChildText(self.viewGO, "rotate/desc_container/scroll_desc/Viewport/Content/#txt_info")
	self._goop = gohelper.findChild(self.viewGO, "rotate/#go_op")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op/#btn_back")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op/#btn_fight")
	self._simagedesccontainer = gohelper.findChildSingleImage(self.viewGO, "rotate/desc_container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianGameTipView:addEvents()
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
end

function YaXianGameTipView:removeEvents()
	self._btnblock:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnfight:RemoveClickListener()
end

function YaXianGameTipView:_btnblockOnClick()
	self:fallBack()
end

function YaXianGameTipView:_btnbackOnClick()
	self:fallBack()
end

function YaXianGameTipView:_btnfightOnClick()
	YaXianDungeonController.instance:enterFight(self.battleId)
	self:closeThis()
end

function YaXianGameTipView:_editableInitView()
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnResetView, self.closeThis, self)
	self._simagedesccontainer:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
end

function YaXianGameTipView:onUpdateParam()
	return
end

function YaXianGameTipView:onOpen()
	self.interactId = self.viewParam.interactId
	self.interactCo = YaXianConfig.instance:getInteractObjectCo(YaXianEnum.ActivityId, self.interactId)
	self.battleId = tonumber(self.interactCo.param)

	self:refreshUI()
end

function YaXianGameTipView:refreshUI()
	self._txttitle.text = self.interactCo.battleName
	self._txtrecommondlevel.text = HeroConfig.instance:getCommonLevelDisplay(self.interactCo.recommendLevel)
	self._txtinfo.text = self.interactCo.battleDesc
end

function YaXianGameTipView:fallBack()
	Activity115Rpc.instance:sendAct115RevertRequest(YaXianGameModel.instance:getActId())
	self:closeThis()
end

function YaXianGameTipView:onClose()
	local state = YaXianGameController.instance.state

	if state then
		state:disposeEventState()
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnStateFinish, YaXianGameEnum.GameStateType.Battle)
end

function YaXianGameTipView:onDestroyView()
	self._simagedesccontainer:UnLoadImage()
end

return YaXianGameTipView
