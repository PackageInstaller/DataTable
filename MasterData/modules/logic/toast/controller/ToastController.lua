-- chunkname: @modules/logic/toast/controller/ToastController.lua

module("modules.logic.toast.controller.ToastController", package.seeall)

local ToastController = class("ToastController", BaseController)

function ToastController:onInit()
	self._msgList = {}
	self._notToastList = {}
end

function ToastController:onInitFinish()
	return
end

function ToastController:addConstEvents()
	self.registerCallback(self, ToastEvent.ClearCacheToastInfo, self._onClearCacheToastInfo, self)
end

function ToastController:_onClearCacheToastInfo(msg)
	for k, v in pairs(self._notToastList) do
		if v == msg then
			self._notToastList[k] = nil

			break
		end
	end
end

function ToastController:reInit()
	self._msgList = {}
	self._notToastList = {}
end

function ToastController:showToastWithIcon(toastid, icon, ...)
	self._icon = icon

	self:showToast(toastid, ...)

	self._icon = nil
end

function ToastController:showToastWithExternalCall()
	return
end

function ToastController:_showToast(msgObject, isTop)
	if isTop then
		if not ViewName.ToastTopView then
			local viewName = ViewName.ToastView

			if not ViewMgr.instance:isOpen(viewName) then
				ViewMgr.instance:openView(viewName, msgObject)

				return
			end

			if ViewMgr.instance:isOpenFinish(viewName) then
				self:dispatchEvent(ToastEvent.ShowToast, msgObject)

				return
			end

			table.insert(self._msgList, msgObject)
		end
	end
end

function ToastController:showToast(toastid, ...)
	local o = self:PackToastObj(toastid, ...)

	if o and (isDebugBuild or o.co.notShow == 0) then
		self:_showToast(o)
	end
end

function ToastController:PackToastObj(toastid, ...)
	if toastid then
		::label_10_0::

		local co = ToastConfig.instance:getToastCO(toastid)

		if not co then
			logError(tostring(toastid) .. " 配置提示语！！《P飘字表》- export_飘字表")

			return
		end

		local extra = {
			...
		}
		local contain = false

		if co.notMerge == 0 then
			for _, v in pairs(self._notToastList) do
				local sameExtra = false

				if v.extra and #extra == #v.extra then
					local same = true

					for i = 1, #extra do
						if extra[i] ~= v.extra[i] then
							same = false

							break
						end
					end

					sameExtra = same
				end

				if v.toastid == toastid and sameExtra then
					contain = true

					break
				end
			end
		end

		local key = ""

		if #extra > 0 then
			for i = 1, #extra do
				key = key .. tostring(extra[i])
			end
		end

		key = tostring(toastid) .. key

		if not contain then
			local o = {}

			o.toastid = toastid
			o.extra = extra
			o.time = ServerTime.now()
			self._notToastList[key] = o
		elseif not self:_isExpire(toastid, self._notToastList[key].time) then
			return
		else
			self._notToastList[key].time = ServerTime.now()
		end

		if not self._notToastList[key] then
			local o = {}

			o.co = co
			o.extra = extra
			o.sicon = self._icon

			return o
		end
	end
end

ToastController.DefaultIconType = 11

function ToastController:showToastWithString(msg, isTop)
	if self._notToastList[msg] and not self:_isExpire(nil, self._notToastList[msg].time) then
		return
	end

	local msgObject = {
		co = {
			tips = msg,
			icon = ToastController.DefaultIconType
		},
		time = ServerTime.now()
	}

	self._notToastList[msg] = msgObject

	self:_showToast(msgObject, isTop)
end

function ToastController:showToastWithCustomData(toastid, toastObjHandler, toastObjHandlerObj, toastObjHandlerParam, ...)
	local toastObj = self:PackToastObj(toastid, ...)

	if toastObj then
		if toastObjHandler then
			toastObjHandler(toastObjHandlerObj, toastObj, toastObjHandlerParam)
		end

		self:_showToast(toastObj)
	end
end

function ToastController:getToastMsg(toastid, ...)
	local o = self:PackToastObj(toastid, ...)

	return (o or nil) and (o.extra and #o.extra > 0 and GameUtil.getSubPlaceholderLuaLang(o.co.tips, o.extra) or o.co.tips)
end

function ToastController:getToastMsgWithTableParam(toastId, paramList)
	if toastId then
		::label_14_0::

		local toastCO = ToastConfig.instance:getToastCO(toastId)

		if not toastCO then
			logError("[ToastController] P飘字表.xlsx - export_飘字表 sheet error 不存在 toastId = " .. tostring(toastId))

			return ""
		end

		return paramList and #paramList > 0 and GameUtil.getSubPlaceholderLuaLang(toastCO.tips, paramList) or toastCO.tips
	end
end

function ToastController:isExpire(time)
	return ServerTime.now() - time >= 4
end

function ToastController:_isExpire(toastId, time)
	return ServerTime.now() - time >= self:getShowTime(toastId)
end

function ToastController:getShowTime(toastId)
	return ToastParamEnum.LifeTime[toastId] or 4
end

ToastController.instance = ToastController.New()

return ToastController
