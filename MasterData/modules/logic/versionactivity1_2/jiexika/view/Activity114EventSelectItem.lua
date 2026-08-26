-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114EventSelectItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114EventSelectItem", package.seeall)

local Activity114EventSelectItem = class("Activity114EventSelectItem", LuaCompBase)

function Activity114EventSelectItem:ctor(params)
	self._parent = params.parent
	self._index = params.index
	self._go = nil
	self._isSelect = nil
end

function Activity114EventSelectItem:init(go)
	self._go = go
	self._btnClick = gohelper.findChildButtonWithAudio(go, "#btn_click")
	self._goselect = gohelper.findChild(go, "#go_selected")
	self._btnSelect = gohelper.findChildButtonWithAudio(go, "#go_selected/#btn_select")
	self._imgSelect = gohelper.findChildSingleImage(go, "#go_selected/#btn_select")
	self._goselectonce = gohelper.findChild(go, "#go_selected/#go_once")
	self._txtselectoncedesc = gohelper.findChildTextMesh(go, "#go_selected/#go_once/#txt_desc")
	self._txtselectdesc = gohelper.findChildTextMesh(go, "#go_selected/#txt_desc")
	self._goselectcheck = gohelper.findChild(go, "#go_selected/#go_check")
	self._txtselectneed = gohelper.findChildTextMesh(go, "#go_selected/#go_check/#txt_need")
	self._txtselectrate = gohelper.findChildTextMesh(go, "#go_selected/#go_check/#txt_rate")
	self._btnselecthelp = gohelper.findChildButtonWithAudio(go, "#go_selected/#go_check/#btn_help")
	self._goselecttippos = gohelper.findChildComponent(go, "#go_selected/#go_tippos", typeof(UnityEngine.Transform))
	self._gounselect = gohelper.findChild(go, "#go_unselected")
	self._txtunselectdesc = gohelper.findChildTextMesh(go, "#go_unselected/#txt_desc")
	self._gounselectcheck = gohelper.findChild(go, "#go_unselected/#go_check")
	self._txtunselectneed = gohelper.findChildTextMesh(go, "#go_unselected/#go_check/#txt_need")
	self._txtunselectrate = gohelper.findChildTextMesh(go, "#go_unselected/#go_check/#txt_rate")
	self._btnunselecthelp = gohelper.findChildButtonWithAudio(go, "#go_unselected/#go_check/#btn_help")
	self._gounselecttippos = gohelper.findChildComponent(go, "#go_unselected/#go_tippos", typeof(UnityEngine.Transform))
	self._goSelectAnim = SLFramework.AnimatorPlayer.Get(self._goselect)
	self._goUnSelectAnim = self._gounselect:GetComponent(typeof(UnityEngine.Animator))
	self._isFirstEnter = true

	self:setSelect(false)
end

function Activity114EventSelectItem:addEventListeners()
	self._btnClick:AddClickListener(self.setSelect, self, true)
	self._btnSelect:AddClickListener(self.selectChoice, self)
	self._btnselecthelp:AddClickListener(self.showHelp, self, self._goselecttippos)
	self._btnunselecthelp:AddClickListener(self.showHelp, self, self._gounselecttippos)
end

function Activity114EventSelectItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnselecthelp:RemoveClickListener()
	self._btnunselecthelp:RemoveClickListener()
end

function Activity114EventSelectItem:showHelp(trans)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
	self._parent:showTips(self._data, trans.position)
end

function Activity114EventSelectItem:setSelect(isSelect)
	if isSelect == self._isSelect then
		return
	end

	self._isSelect = isSelect

	if self._isFirstEnter then
		gohelper.setActive(self._goselect, false)
		gohelper.setActive(self._gounselect, true)

		self._isFirstEnter = false
	elseif isSelect then
		self._parent:onSelectIndex(self._index)
		gohelper.setActive(self._goselect, true)
		gohelper.setActive(self._gounselect, false)

		self._goselect:GetComponent(typeof(UnityEngine.Animator)).enabled = true
	else
		self._goSelectAnim:Stop()
		self._goSelectAnim:Play(UIAnimationName.Close, self.playUnSelectAnimFinish, self)
	end
end

function Activity114EventSelectItem:playUnSelectAnimFinish()
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._gounselect, true)
	self._goUnSelectAnim:Play(UIAnimationName.Switch, 0, 0)
end

function Activity114EventSelectItem:updateData(showType, data, callback, callObj)
	self._data = data
	self._selectCb = callback
	self._selectCbObj = callObj

	gohelper.setActive(self._goselectonce, showType == Activity114Enum.EventContentType.Check_Once)
	gohelper.setActive(self._goselectcheck, showType ~= Activity114Enum.EventContentType.Normal)
	gohelper.setActive(self._gounselectcheck, showType ~= Activity114Enum.EventContentType.Normal)
	gohelper.setActive(self._txtselectdesc, showType ~= Activity114Enum.EventContentType.Check_Once)
	recthelper.setWidth(self._txtunselectdesc.transform, showType == Activity114Enum.EventContentType.Check_Once and 300 or 500)
	recthelper.setWidth(self._txtselectdesc.transform, showType == Activity114Enum.EventContentType.Check_Once and 340 or 700)

	local level = 5

	if showType == Activity114Enum.EventContentType.Normal then
		self._txtselectdesc.text = data
		self._txtunselectdesc.text = data
	else
		if showType == Activity114Enum.EventContentType.Check then
			self._txtselectdesc.text = data.desc
		else
			self._txtselectoncedesc.text = data.desc
		end

		self._txtunselectdesc.text = data.desc
		level = data.level
		self._txtselectrate.text = data.rateDes
		self._txtunselectrate.text = data.rateDes
		self._txtselectneed.text = data.realVerify
		self._txtunselectneed.text = data.realVerify

		SLFramework.UGUI.GuiHelper.SetColor(self._txtselectneed, data.threshold ~= data.realVerify and "#E19C60" or "#FFFFFF")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtunselectneed, data.threshold ~= data.realVerify and "#E19C60" or "#FFFFFF")
	end

	self._imgSelect:LoadImage(ResUrl.getAct114Image("btn_xuanze_" .. level))
end

function Activity114EventSelectItem:selectChoice()
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

	self._isFirstEnter = true

	self._selectCb(self._selectCbObj, self._index)
end

function Activity114EventSelectItem:destory()
	gohelper.destroy(self._go)
end

function Activity114EventSelectItem:onDestroy()
	self._imgSelect:UnLoadImage()

	self._go = nil
end

return Activity114EventSelectItem
