-- chunkname: @modules/logic/room/view/critter/train/RoomCritterTrainEventResultView.lua

module("modules.logic.room.view.critter.train.RoomCritterTrainEventResultView", package.seeall)

local RoomCritterTrainEventResultView = class("RoomCritterTrainEventResultView", BaseView)

function RoomCritterTrainEventResultView:onInitView()
	self._golefttopbtns = gohelper.findChild(self.viewGO, "#go_lefttopbtns")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")
	self._goexittips = gohelper.findChild(self.viewGO, "#go_exittips")
	self._goattribute = gohelper.findChild(self.viewGO, "#go_attribute")
	self._goattributeup = gohelper.findChild(self.viewGO, "#go_attributeup")
	self._txtup = gohelper.findChildText(self.viewGO, "#go_attributeup/attributeup/up/#txt_up")
	self._goattributeupitem = gohelper.findChild(self.viewGO, "#go_attributeup/attributeup")
	self._goattributeupeffect = gohelper.findChild(self.viewGO, "#attributeup_effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainEventResultView:addEvents()
	return
end

function RoomCritterTrainEventResultView:removeEvents()
	return
end

function RoomCritterTrainEventResultView:_onCloseFullView(viewName)
	local sceneGO = GameSceneMgr.instance:getScene(SceneType.Room):getSceneContainerGO()

	gohelper.setActive(sceneGO, true)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

function RoomCritterTrainEventResultView:_addEvents()
	self._exitBtn:AddClickListener(self._onExitClick, self)
end

function RoomCritterTrainEventResultView:_removeEvents()
	self._exitBtn:RemoveClickListener()
end

function RoomCritterTrainEventResultView:_onExitClick()
	self:closeThis()
end

function RoomCritterTrainEventResultView:_editableInitView()
	self._selectItems = {}
	self._optionId = 1
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local go = self:getResInst(RoomCritterTrainDetailItem.prefabPath, self._goattribute)

	self._attributeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterTrainDetailItem, self)
	self._exitBtn = gohelper.getClick(self._goexittips)

	self:_addEvents()
	gohelper.setActive(self._goattribute, false)
	gohelper.setActive(self._goconversation, false)
	gohelper.setActive(self._goexittips, false)
	gohelper.setActive(self._goattributeup, false)
	gohelper.setActive(self._goattributeupitem, false)
end

function RoomCritterTrainEventResultView:_startShowResult(attributeMOs)
	gohelper.setActive(self._goexittips, true)
	gohelper.setActive(self._goattributeup, true)
	gohelper.setActive(self._goattribute, true)
	gohelper.setActive(self._goattributeupeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_peixun)
	self._viewAnim:Play("open", 0, 0)

	self._attributeMOs = attributeMOs

	self._attributeItem:playLevelUp(attributeMOs, true)

	self._repeatCount = 0

	TaskDispatcher.runRepeat(self._showAttribute, self, 0.3, #attributeMOs)
end

function RoomCritterTrainEventResultView:_showAttribute()
	self._repeatCount = self._repeatCount + 1

	if not self._attributeMOs or self._repeatCount > #self._attributeMOs then
		return
	end

	local parentGo = gohelper.findChild(self._goattributeup, tostring(self._repeatCount))
	local go = gohelper.clone(self._goattributeupitem)

	gohelper.addChild(parentGo, go)
	gohelper.setActive(go, true)

	local txtattributeup = gohelper.findChildText(go, "up/#txt_up")
	local attributeMO = self._attributeMOs[self._repeatCount]
	local attName = CritterConfig.instance:getCritterAttributeCfg(attributeMO.attributeId).name
	local attValue = attributeMO.value

	txtattributeup.text = string.format("%s + %s", attName, attValue)
end

function RoomCritterTrainEventResultView:onOpen()
	self._critterMO = self.viewParam.critterMO
	self._addAttributeMOs = self.viewParam.addAttributeMOs

	self._attributeItem:onUpdateMO(self._critterMO)
	self:_startShowResult(self._addAttributeMOs)
end

function RoomCritterTrainEventResultView:onClose()
	return
end

function RoomCritterTrainEventResultView:onDestroyView()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._showAttribute, self)

	if self._selectItems then
		for _, v in pairs(self._selectItems) do
			v:destroy()
		end

		self._selectItems = nil
	end

	self._attributeItem:onDestroy()
end

return RoomCritterTrainEventResultView
