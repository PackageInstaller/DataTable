-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165KeywordItem.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165KeywordItem", package.seeall)

local Activity165KeywordItem = class("Activity165KeywordItem", LuaCompBase)

function Activity165KeywordItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtkeywords = gohelper.findChildText(self.viewGO, "#txt_keywords")
	self._btnkeywords = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_keywords")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity165KeywordItem:addEvents()
	self._btnkeywords:AddClickListener(self._btnkeywordsOnClick, self)
end

function Activity165KeywordItem:removeEvents()
	self._btnkeywords:RemoveClickListener()
end

function Activity165KeywordItem:addEventListeners()
	self:addEvents()
end

function Activity165KeywordItem:removeEventListeners()
	self:removeEvents()
	self:_removeEventListeners()
end

function Activity165KeywordItem:_btnclickOnClick()
	return
end

function Activity165KeywordItem:_btnkeywordsOnClick()
	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickUsedKeyword, self._mo.keywordId)
	self:onRefresh()
end

function Activity165KeywordItem:_btnkewordsOnClick()
	return
end

function Activity165KeywordItem:_removeEventListeners()
	if self.drag then
		self.drag:RemoveDragBeginListener()
		self.drag:RemoveDragListener()
		self.drag:RemoveDragEndListener()
	end
end

function Activity165KeywordItem:_editableInitView()
	self._canvasgroup = self.viewGO:GetComponent(gohelper.Type_CanvasGroup)
end

function Activity165KeywordItem:init(go)
	self.viewGO = go

	gohelper.setActive(go, true)
	self:onInitView()
end

function Activity165KeywordItem:setDragEvent(beginDragEvent, dragEvent, endDragEvent, view)
	if self._mo then
		self.drag = SLFramework.UGUI.UIDragListener.Get(self._btnkeywords.gameObject)

		self.drag:AddDragBeginListener(beginDragEvent, view, self._mo.keywordId)
		self.drag:AddDragListener(dragEvent, view)
		self.drag:AddDragEndListener(endDragEvent, view)
	end
end

function Activity165KeywordItem:onUpdateMO(mo)
	self._mo = mo

	if mo then
		self._txtkeywords.text = mo.keywordCo.text

		local icon = mo.keywordCo.pic

		if not string.nilorempty(icon) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(self._imageicon, icon)
		end
	end
end

function Activity165KeywordItem:onRefresh()
	if self._mo.isUsed then
		self:Using()
	else
		self:clearUsing()
	end
end

function Activity165KeywordItem:Using()
	self:_setAlpha(0.5)
end

function Activity165KeywordItem:clearUsing()
	self:_setAlpha(1)
end

function Activity165KeywordItem:_setAlpha(alpha)
	if self._canvasgroup then
		self._canvasgroup.alpha = alpha
	end
end

return Activity165KeywordItem
