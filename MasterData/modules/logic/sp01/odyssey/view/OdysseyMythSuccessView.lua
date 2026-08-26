-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMythSuccessView.lua

module("modules.logic.sp01.odyssey.view.OdysseyMythSuccessView", package.seeall)

local OdysseyMythSuccessView = class("OdysseyMythSuccessView", BaseView)

function OdysseyMythSuccessView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gotargets = gohelper.findChild(self.viewGO, "#go_targets")
	self._gotargetitem = gohelper.findChild(self.viewGO, "#go_targets/#go_targetitem")
	self._recordList = self:getUserDataTb_()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyMythSuccessView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function OdysseyMythSuccessView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function OdysseyMythSuccessView:_btncloseOnClick()
	self:closeThis()
end

function OdysseyMythSuccessView:_editableInitView()
	return
end

function OdysseyMythSuccessView:onUpdateParam()
	return
end

function OdysseyMythSuccessView:onOpen()
	self._resultMo = OdysseyModel.instance:getFightResultInfo()

	self:_initTargetItem()
end

function OdysseyMythSuccessView:_initTargetItem()
	self._elementId = self._resultMo:getElementId()
	self._elementCo = OdysseyConfig.instance:getElementFightConfig(self._elementId)

	local param = GameUtil.splitString2(self._elementCo.param, true)
	local fightFinishedTaskIdList = self._resultMo:getFightFinishedTaskIdList()

	for i, value in ipairs(param) do
		local item = self._recordList[i]

		if not item then
			item = {
				go = gohelper.clone(self._gotargetitem, self._gotargets, "target" .. i)
			}
			item.gofinish = gohelper.findChild(item.go, "go_finish")
			item.txtfinishdesc = gohelper.findChildText(item.go, "go_finish/#txt_taskdesc")
			item.imagefinishicon = gohelper.findChildImage(item.go, "go_finish/#image_icon")
			item.gounfinish = gohelper.findChild(item.go, "go_unfinish")
			item.txtunfinishdesc = gohelper.findChildText(item.go, "go_unfinish/#txt_taskdesc")
			item.imageunfinishicon = gohelper.findChildImage(item.go, "go_unfinish/#image_icon")
			item.animtor = item.go:GetComponent(gohelper.Type_Animator)

			table.insert(self._recordList, item)
		end

		gohelper.setActive(item.go, true)

		local index = value[1]
		local descId = value[2]
		local isFinish = tabletool.indexOf(fightFinishedTaskIdList, descId)
		local co = OdysseyConfig.instance:getFightTaskDescConfig(descId)

		item.txtfinishdesc.text = co.desc
		item.txtunfinishdesc.text = co.desc

		local name = "pingji_x_" .. index

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(item.imagefinishicon, name)
		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(item.imageunfinishicon, name)
		gohelper.setActive(item.gofinish, isFinish)
		gohelper.setActive(item.gounfinish, not isFinish)

		if isFinish then
			item.animtor:Update(0)
			item.animtor:Play("open", 0, 0)
		end
	end
end

function OdysseyMythSuccessView:onClose()
	OdysseyRpc.instance:sendOdysseyGetInfoRequest(function()
		ViewMgr.instance:openView(ViewName.OdysseyMythResultView)
	end, self)
end

function OdysseyMythSuccessView:onDestroyView()
	return
end

return OdysseyMythSuccessView
