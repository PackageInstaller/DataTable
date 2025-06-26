-- chunkname: @IQIGame\\UI\\Common\\PopupList\\UIPopupListPopupBtn.lua

local UIPopupListPopupBtn = {}

function UIPopupListPopupBtn.New(view, clickEventHandler)
	local obj = Clone(UIPopupListPopupBtn)

	obj:__Init(view, clickEventHandler)

	return obj
end

function UIPopupListPopupBtn:__Init(view, clickEventHandler)
	self.gameObject = view
	self.clickEventHandler = clickEventHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	if self.ExtendInitFunc ~= nil then
		self.ExtendInitFunc(self)
	end

	function self.__OnClickEventProxy()
		self:__OnClickEventHandler()
	end

	self:__AddListeners()
end

function UIPopupListPopupBtn:__AddListeners()
	if self.ExtendAddListenersFunc ~= nil then
		self.ExtendAddListenersFunc(self)
	end

	self.PopupButton:GetComponent("Button").onClick:AddListener(self.__OnClickEventProxy)
end

function UIPopupListPopupBtn:__RemoveListeners()
	if self.ExtendRemoveListenersFunc ~= nil then
		self.ExtendRemoveListenersFunc(self)
	end

	self.PopupButton:GetComponent("Button").onClick:RemoveListener(self.__OnClickEventProxy)
end

function UIPopupListPopupBtn:Dispose()
	self:__RemoveListeners()

	self.clickEventHandler = nil

	if self.ExtendDisposeFunc ~= nil then
		self.ExtendRemoveListenersFunc(self)
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function UIPopupListPopupBtn:__OnClickEventHandler()
	if self.clickEventHandler ~= nil then
		self.clickEventHandler()
	end
end

function UIPopupListPopupBtn:RefreshShow(data, isSelect)
	if self.ExtendShowFunc ~= nil then
		self.ExtendShowFunc(self, data, isSelect)
	end
end

return UIPopupListPopupBtn
