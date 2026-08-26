-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129View.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129View", package.seeall)

local Activity129View = class("Activity129View", BaseView)

function Activity129View:onInitView()
	self.simageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity129View:addEvents()
	return
end

function Activity129View:removeEvents()
	return
end

function Activity129View:_editableInitView()
	self.simageBg:LoadImage("singlebg/v1a4_tokenstore_singlebg/v1a4_tokenstore_fullbg1.png")
end

function Activity129View:onUpdateParam()
	return
end

function Activity129View:onOpen()
	self.actId = self.viewParam.actId

	Activity129Rpc.instance:sendGet129InfosRequest(self.actId)
	ActivityEnterMgr.instance:enterActivity(self.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self.actId
	})
end

function Activity129View:onClose()
	Activity129Model.instance:setSelectPoolId(nil, true)
end

function Activity129View:onDestroyView()
	self.simageBg:UnLoadImage()
end

return Activity129View
