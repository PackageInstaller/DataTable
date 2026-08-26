-- chunkname: @modules/logic/character/view/CharacterTalentChessFilterView.lua

module("modules.logic.character.view.CharacterTalentChessFilterView", package.seeall)

local CharacterTalentChessFilterView = class("CharacterTalentChessFilterView", BaseView)

function CharacterTalentChessFilterView:onInitView()
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closefilterview")
	self._goitem = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_item")
	self._goselect = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_item/#go_select")
	self._golocked = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_item/#go_locked")
	self._txtstylename = gohelper.findChildText(self.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#txt_stylename")
	self._gocareer = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#go_career")
	self._txtlabel = gohelper.findChildText(self.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#go_career/#txt_label")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentChessFilterView:addEvents()
	self._btnclosefilterview:AddClickListener(self._btnclosefilterviewOnClick, self)
	self:_addEvents()
end

function CharacterTalentChessFilterView:removeEvents()
	self._btnclosefilterview:RemoveClickListener()
	self:_removeEvents()
end

function CharacterTalentChessFilterView:_btnclosefilterviewOnClick()
	self._animPlayer:Play("close", self.closeThis, self)
end

function CharacterTalentChessFilterView:_editableInitView()
	self._txtTitleCn = gohelper.findChildText(self.viewGO, "container/title/dmgTypeCn")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "container/title/dmgTypeCn/dmgTypeEn")
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function CharacterTalentChessFilterView:onUpdateParam()
	return
end

function CharacterTalentChessFilterView:onOpen()
	self._heroId = self.viewParam.heroId

	local _heroMo = HeroModel.instance:getByHeroId(self._heroId)
	local heroType = _heroMo:getTalentTxtByHeroType()

	self._txtTitleCn.text = luaLang("talent_style_title_cn_" .. heroType)
	self._txtTitleEn.text = luaLang("talent_style_title_en_" .. heroType)

	TalentStyleModel.instance:openView(self._heroId)
	self:_refreshVidew()
end

function CharacterTalentChessFilterView:onClose()
	return
end

function CharacterTalentChessFilterView:onDestroyView()
	return
end

function CharacterTalentChessFilterView:_addEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onUseTalentStyleReply, self)
end

function CharacterTalentChessFilterView:_removeEvents()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onUseTalentStyleReply, self)
end

function CharacterTalentChessFilterView:_onUseTalentStyleReply(msg)
	self:_refreshVidew()
end

function CharacterTalentChessFilterView:onClickModalMask(msg)
	self:closeThis()
end

function CharacterTalentChessFilterView:_refreshVidew()
	TalentStyleListModel.instance:refreshData(self._heroId)
end

return CharacterTalentChessFilterView
