---@class UIMgr:UIManager
local UIMgrExtension = {}
function UIMgrExtension:extensionInit()
	---@type table<integer, uiData[]>
	self._uiDataGroupQueue = {} -- UI数据组队列
	self._depositUIQueue = {} -- 寄存UI队列
	self._curGroupId = 1 -- 当前组ID
	self._curWnd = nil -- 当前窗口
	self._curWndData = nil -- 当前窗口数据
	self._clickEffect = nil -- 点击特效
	self._clickEffectParticle = nil -- 点击特效粒子
	self._clickEffectLoading = false -- 点击特效加载状态

	self._dragEffect = nil -- 拖拽特效
	self._dragEffectParticle = nil -- 拖拽特效粒子
	self._dragEffectLoading = false -- 拖拽特效加载状态

	self.isMouseDown = false -- 鼠标是否按下
	self._clickPos = nil -- 点击位置
	self._touchId = nil -- 首个触摸点 fingerId（真机多点触摸时跟踪第一指）
	self._lastWnd = nil -- 上一个窗口
	self._depositToastQueue = {} -- 需要显示的toast队列
	self._needDepositToast = false -- 是否需要寄存toast
	self._depositToastType = 0	-- 寄存toast类型

	-- popUI 串行执行队列：保证多次 popUI 按调用顺序依次执行
	-- 当某个 popUI 需要等待服务器数据时，后续的 popUI 不会抢先执行
	self._popUISeqQueue = {}
	self._popUISeqRunning = false

    -- 自动remove
    self.autoRemoveWhenClose = true
end

---@class uiData UI数据
---@field name string UI名称
---@field data any 数据
---@field callFunc function 回调
---@field noExitAni boolean 是否无退出动画
---@field noAni boolean 是否无动画
---@field endCallBack function 结束回调
---@field isCover boolean 是否覆盖当前窗口

---打开loading界面
---@param name string UI名称
---@param data any 数据
---@param callFunc function 回调
---@param noExitAni boolean 是否无退出动画
---@param noAni boolean 是否无动画
---@param endCallBack function 结束回调
function UIMgrExtension:popLoadingUI(name, data, callFunc, noExitAni, noAni, endCallBack)
	local source = self:getCurUIName()
	---@type uiData
	local uiData = {
		name = name,
		data = data,
		callFunc = callFunc,
		noExitAni = noExitAni,
		noAni = noAni,
		endCallBack = endCallBack,
		isCover = false, -- 是否覆盖当前窗口
		source = source
	}
	-- 弹出新界面
	self:_popUIDo(name, uiData.data, uiData.callFunc, uiData.noExitAni, uiData.noAni, uiData.endCallBack, source)
end

---打开界面
---@param name string UI名称
---@param data any? 数据
---@param callFunc function? 回调
---@param noExitAni boolean? 是否无退出动画
---@param noAni boolean? 是否无动画
---@param endCallBack function? 结束回调
function UIMgrExtension:popUI(name, data, callFunc, noExitAni, noAni, endCallBack)
	local source = self:getCurUIName()
	---@type uiData
	local uiData = {
		name = name,
		data = data,
		callFunc = callFunc,
		noExitAni = noExitAni,
		noAni = noAni,
		endCallBack = endCallBack,
		isCover = false, -- 是否覆盖当前窗口
		source = source
	}
	
	self:_popUIPushData(name, function()
		self:_popUI(name, uiData)
	end)
end

---界面进入打开队列（待当前界面关闭后再打开）
---@param name string UI名称
---@param data any 数据
---@param callFunc function 回调
---@param noExitAni boolean 是否无退出动画
---@param noAni boolean 是否无动画
---@param endCallBack function 结束回调
function UIMgrExtension:popUINext(name, data, callFunc, noExitAni, noAni, endCallBack)
	local source = self:getCurUIName()
	local uiData = {
		name = name,
		data = data,
		callFunc = callFunc,
		noExitAni = noExitAni,
		noAni = noAni,
		endCallBack = endCallBack,
		source = source
	}
	table.insert(self:getUIDataGroup(self._curGroupId), uiData)
	GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
end

---打开覆盖型界面（覆盖在当前界面上）
---@param name string UI名称
---@param data? any 数据
---@param callFunc? function 回调
---@param noExitAni? boolean 是否无退出动画
---@param noAni? boolean 是否无动画
---@param endCallBack? function 结束回调
function UIMgrExtension:popUICover(name, data, callFunc, noExitAni, noAni, endCallBack)
	local source = self:getCurUIName()
	local uiData = {
		name = name,
		data = data,
		callFunc = callFunc,
		noExitAni = noExitAni,
		noAni = noAni,
		endCallBack = endCallBack,
		isCover = true, -- 是否覆盖当前窗口
		source = source
	}

	self:_popUIPushData(name, function()
		self:_popUI(name, uiData)
	end)
end

---打开基础界面（当前场景没有其他界面的时候打开）
---@param name string UI名称
---@param data any 数据
---@param callFunc function 回调
---@param noExitAni boolean 是否无退出动画
---@param noAni boolean 是否无动画
---@param endCallBack function 结束回调
function UIMgrExtension:popUIBase(name, data, callFunc, noExitAni, noAni, endCallBack)
	local wndQueue = self:getUIDataGroup(self._curGroupId)
	if not self._curWnd and not next(wndQueue) then
		self:popUI(name, data, callFunc, noExitAni, noAni, endCallBack)
	else
		if callFunc then
			callFunc()
		end
		if endCallBack then
			endCallBack()
		end
	end
end

---替换界面
---@param name string UI名称
---@param data any 数据
---@param callFunc function? 回调
---@param noExitAni boolean? 是否无退出动画
---@param noAni boolean? 是否无动画
---@param endCallBack function? 结束回调
function UIMgrExtension:replaceUI(name, data, callFunc, noExitAni, noAni, endCallBack)
	self:popUINext(name, data, callFunc, noExitAni, noAni, endCallBack)
	self:closeCurrentUIImmediately()
end

---内部方法，用于打开界面
---@param name string UI名称
---@param uiData uiData UI数据
function UIMgrExtension:_popUI(name, uiData)
	local uiCfg = Config.GetUIConfigInfo(name)
	if uiCfg == nil then
		return
	end

	-- 记录当前界面数据
	if uiCfg.UIType == UIType.Wnd then
		if self._curWnd then
			-- 将当前界面数据插入到当前组的UI数据组队列中
			self._curWndData.isCovered = uiData.isCover
			self:_removeUIData(self._curWnd)
			table.insert(self:getUIDataGroup(self._curGroupId), self._curWndData)
			GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
			-- if not uiData.isCover then
			-- 	-- 如果不覆盖当前界面，则关闭当前界面
			-- 	self:hideUI(self._curWndData.name)
			-- 	-- self:_closeUI(self._curWndData.name, self._curWndData.noExitAni, self._curWndData.callFunc, self._curWndData.noAni) -- 关闭当前界面
			-- end
		end
		self._lastWnd = self._curWnd -- 记录上一个窗口
		self._curWnd = name -- 设置当前界面为新界面
		self._curWndData = uiData -- 设置当前界面数据为新数据

		--播放BGM
		self:PlayBGM(uiCfg)
	elseif uiCfg.UIType == UIType.Toast and uiCfg.id ~= "Toast" then
		--判断Toast界面是否先寄存
		if self._needDepositToast then
			table.insert(self._depositToastQueue, {name = name, uiData = uiData})
			return
		end
	end

	-- 弹出新界面
	self:_popUIDo(name, uiData.data, uiData.callFunc, uiData.noExitAni, uiData.noAni, uiData.endCallBack, uiData.source)
end

--开启寄存Toast模式
---@param functionType integer 功能模式
function UIMgrExtension:startDepositToast(functionType)
	self._needDepositToast = true
	self._depositToastType = functionType
end

--寄存Toast结束
---@param functionType integer 功能模式
function UIMgrExtension:endDepositToast(functionType)
	if self._depositToastType == functionType then
		self._needDepositToast = false
		self._depositToastType = 0
		self:_showDepositToast()
	end
end

--重置寄存Toast状态
function UIMgrExtension:resetDepositToast()
	self._needDepositToast = false
	self._depositToastType = 0
	self:_showDepositToast()
end

--显示寄存的Toast界面
function UIMgrExtension:_showDepositToast()
	if #self._depositToastQueue > 0 then
		local toastData = table.remove(self._depositToastQueue, 1)
		local name = toastData.name
		local uiData = toastData.uiData
		if uiData.endCallBack then
			uiData.newEndCallBack = function()
				uiData.endCallBack()
				self:_showDepositToast()
			end
		else
			uiData.newEndCallBack = function()
				self:_showDepositToast()
			end
		end
		self:_popUIDo(name, uiData.data, uiData.callFunc, uiData.noExitAni, uiData.noAni, uiData.newEndCallBack, uiData.source)
	end
end

---寄存UI（保存UI当前状态，打开其他界面再退回后不刷新）
function UIMgrExtension:depositUI(instance)
	self._depositUIQueue[instance] = instance
end

---获取指定组的UI数据组队列
---@param groupId integer 组ID
function UIMgrExtension:getUIDataGroup(groupId)
	if not self._uiDataGroupQueue[groupId] then
		self._uiDataGroupQueue[groupId] = {} -- 如果组队列不存在，则创建一个新的
	end
	return self._uiDataGroupQueue[groupId]
end

---获取指定组的UI队列的长度
---@param groupId number 组ID
function UIMgrExtension:getUIGroupNum(groupId)
	if not self._uiDataGroupQueue[groupId] then
		return 0
	end
	return #self._uiDataGroupQueue[groupId]
end

---获取当前界面名称
---@return string UI名称
function UIMgrExtension:getCurUIName()
	return self._curWnd
end

---获取界面数据
---@param name string UI名称
---@return uiData? UI数据
function UIMgrExtension:getExtensionUIData(name)
	local wndQueue = self:getUIDataGroup(self._curGroupId)
	if next(wndQueue) then
		for index, value in ipairs(wndQueue) do
			if value.name == name then
				return value
			end
		end
	end
	return nil
end

---内部方法，获取界面名称
---@param nameOrObj string|any UI名称或对象
function UIMgrExtension:_getUIName(nameOrObj)
	local name
	if type(nameOrObj) == "string" then
		name = nameOrObj
	else
		name = nameOrObj:getClassName()
	end
	return name
end

---内部方法，打开上一个界面
---@param source string? 来源
function UIMgrExtension:_popLastUI(source, endCallBack)
	LuaLogger.ds("UIMgrExtension:_popLastUI 内部方法，打开上一个界面")
	local wndQueue = self:getUIDataGroup(self._curGroupId) -- 获取当前组的UI数据组队列
	LuaLogger.ds("UIMgrExtension:_popLastUI 队列", tablex.dump(wndQueue))
	local list = {}
	if next(wndQueue) then
		--先筛选出覆盖型界面
		local max = #wndQueue
		for i = max, 1, -1 do
			local uiData = wndQueue[i] -- 获取队列中的最后一个UI数据
			uiData.callFunc = nil
			uiData.endCallBack = endCallBack
			--第一个界面要为最顶层界面 所以iscovered为false
			if uiData.isCover then
				--第一个界面的iscovered为true 说明是a b c 当前是关掉c返回b b虽然是cover界面但是是中间层
				if i == max and uiData.isCovered then
					break
				end
				table.insert(list, uiData) -- 如果是覆盖型界面，则将其添加到列表中
				table.remove(wndQueue, i)
			else
				break -- 如果不是覆盖型界面，则退出循环
			end
		end
		local uiData = wndQueue[#wndQueue] -- 获取队列中的不是覆盖型界面的最后一个UI
		uiData.callFunc = nil
		uiData.endCallBack = endCallBack
		--此界面必然是非覆盖型界面
		--list有数据 说明此界面为底图
		if tablex.size(list) > 0 then
			self:_popUI(uiData.name, uiData)
		else
			-- 没有cover界面 说明此界面为返回的第一层界面 需要判断是从其他非覆盖型界面返回还是从覆盖型界面返回
			if not uiData.isCovered then
				--纯新界面 a
				uiData.source = source
				self:_popUI(uiData.name, uiData)
			elseif uiData.isCovered then
				--从cover界面返回的第一层界面 取消被覆盖状态 不重新打开界面 a b -> a
				uiData.isCovered = false
				self._curWnd = uiData.name
				self._curWndData = uiData
				local mgrData = self:getUIData(uiData.name)
				if mgrData and mgrData.isHide then
					self:showUI(uiData.name, uiData.data)
				end
				if endCallBack then
					endCallBack()
				end
			end
		end
		table.remove(wndQueue, #wndQueue)
		--显示覆盖的界面
		for i = #list, 1, -1 do
			local v = list[i]
			LuaLogger.ds("UIMgrExtension:_popLastUI 显示覆盖的界面", v.name)
			self:_popUI(v.name, v)
		end
		GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
	elseif endCallBack then
		endCallBack()
	end
end

function UIMgrExtension:getCurrentUICoverGroup()
	local list = {}
	if self._curWndData and self._curWndData.isCover then
		local wndQueue = self:getUIDataGroup(self._curGroupId)
		if next(wndQueue) then
			--先筛选出覆盖型界面
			local max = #wndQueue
			for i = max, 1, -1 do
				local uiData = wndQueue[i] -- 获取队列中的最后一个UI数据
				if uiData.isCovered then
					table.insert(list, uiData) -- 如果是覆盖型界面，则将其添加到列表中
				else
					break -- 如果不是覆盖型界面，则退出循环
				end
			end
		end
	end
	return list
end

function UIMgrExtension:hideLastUI()
	-- local wndQueue = self:getUIDataGroup(self._curGroupId) -- 获取当前组的UI数据组队列
	-- if next(wndQueue) then
	-- 	local uiData = wndQueue[#wndQueue] -- 获取队列中的最后一个UI数据
	-- 	uiData.callFunc = nil
	-- 	uiData.endCallBack = nil
	-- 	table.remove(wndQueue, #wndQueue)
	-- 	GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
	-- end
end

---切换UI数据组
---@param groupId number 组ID
function UIMgrExtension:switchUIDataGroup(groupId)
	local source = self:getCurUIName()
	self:removeAllUI()

	-- 切换组ID
	self._curGroupId = groupId

	-- 打开当前组的第一个界面
	self:_popLastUI(source)
end

---获取当前界面名称
---@return string UI名称
function UIMgrExtension:getCurrentUIName()
	if (not self._curWndData) then
		return ""
	end
	return self._curWndData.name
end

---获取上一个界面名称
---@return string 上一个UI名称
function UIMgrExtension:getLastUIName()
	if (not self._lastWnd) then
		return ""
	end
	return self._lastWnd
end

---关闭当前界面
function UIMgrExtension:closeCurrentUI(isRemove, noEnterAni, callFunc, noAni)
	LuaLogger.ds("UIMgrExtension:closeCurrentUI", isRemove)
	if isRemove == nil and self.autoRemoveWhenClose == true then
		isRemove = true
	end
	if not self._curWnd then
		return -- 如果没有当前界面，则返回
	end

	local lastUIData = self:getLastUIData()
	if lastUIData then
		self:_doCloseCurrentUI(isRemove, noEnterAni, callFunc, noAni)
	else
		--LuaLogger.ds("UIMgrExtension:closeCurrentUI 上一个界面已删除")
		LoadingMgr:SetUIQuickSwitchStart(function()
			self:_doCloseCurrentUI(isRemove, noEnterAni, callFunc, noAni)
		end)
	end
end

function UIMgrExtension:_doCloseCurrentUI(isRemove, noEnterAni, callFunc, noAni)
	local source = self:getCurUIName()
	if isRemove then
		self:_closeUI(self._curWndData.name, noEnterAni, callFunc, noAni) -- 关闭当前界面
	else
		self:hideUI(self._curWndData.name)
	end
	
	-- local isCover = self._curWndData.isCover
	self._curWnd = nil -- 清空当前界面
	self._curWndData = nil -- 清空当前界面数据
	-- if (isCover) then
	-- 	local wndQueue = self:getUIDataGroup(self._curGroupId) -- 获取当前组的UI数据组队列
	-- 	if next(wndQueue) then
	-- 		local uiData = wndQueue[#wndQueue] -- 获取队列中的最后一个UI数据
	-- 		uiData.callFunc = nil
	-- 		uiData.endCallBack = nil
	-- 		self._curWnd = uiData.name
	-- 		self._curWndData = uiData
	-- 		table.remove(wndQueue, #wndQueue)
	-- 		GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
	-- 	end
	-- else
		-- self:_popLastUI(source) -- 打开上一个界面
	-- end
	self:_popLastUI(source, function()
		LoadingMgr:SetUIQuickSwitchOver()
	end)
end

function UIMgrExtension:getLastUIData()
	local wndQueue = self:getUIDataGroup(self._curGroupId) -- 获取当前组的UI数据组队列
	if next(wndQueue) then
		local uiData = wndQueue[#wndQueue]
		local ui = self:getUIData(uiData.name)
		if ui then
			return true
		else
			return false
		end
	else
		return true
	end
end

---立即关闭当前界面
function UIMgrExtension:closeCurrentUIImmediately(isRemove)
	if not self._curWnd then
		return -- 如果没有当前界面，则返回
	end
	local source = self:getCurUIName()
	if isRemove then
		self:closeUIImmediately(self._curWndData.name, self._curWndData.noExitAni, self._curWndData.callFunc, self._curWndData.noAni) -- 立即关闭当前界面
	else
		self:hideUIImmediately(self._curWndData.name) -- 立即隐藏当前界面
	end
	
	self._curWnd = nil -- 清空当前界面
	self._curWndData = nil -- 清空当前界面数据
	self:_popLastUI(source) -- 打开上一个界面
end

---关闭界面（原UIMgr接口，默认替换为关闭当前界面）
function UIMgrExtension:closeUI(nameOrObj, noEnterAni, callFunc, noAni)
	--LuaLogger.ds("UIMgrExtension:closeUI", nameOrObj, noEnterAni, callFunc, noAni)
	if not nameOrObj then
		self:closeCurrentUI(nil)
		return
	end
	local name = self:_getUIName(nameOrObj)
	local uiCfg = Config.GetUIConfigInfo(name)
	if uiCfg == nil then
		return
	end
	if uiCfg.UIType == UIType.Wnd then
		self:closeCurrentUI()
	else
		self:closeUIImmediately(name, noEnterAni, callFunc, noAni)
	end
end

---关闭Loading界面（原UIMgr接口，默认替换为关闭当前界面）
function UIMgrExtension:closeLoadingUI(nameOrObj, noEnterAni, callFunc, noAni)
	local name = self:_getUIName(nameOrObj)
	local uiCfg = Config.GetUIConfigInfo(name)
	if uiCfg == nil then
		return
	end
	self:closeUIImmediately(name, noEnterAni, callFunc, noAni)
end

---关闭指定界面
function UIMgrExtension:closeSpecificUI(nameOrObj, noEnterAni, callFunc, noAni)
	local name = self:_getUIName(nameOrObj)
	if self._curWndData and self._curWndData.name == name then
		self:closeCurrentUI(true, noEnterAni, callFunc, noAni)
	else
		self:closeUIImmediately(nameOrObj, noEnterAni, callFunc, noAni)
		-- local wndQueue = self:getUIDataGroup(self._curGroupId) -- 获取当前组的UI数据组队列
		-- for i = #wndQueue, 1, -1 do
		-- 	if wndQueue[i].name == name then
		-- 		table.remove(wndQueue, i) -- 从队列中移除指定的UI数据
		-- 		GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
		-- 		break
		-- 	end
		-- end
		self:_removeUIData(name)
	end

	local ui = self:GetUI(name)
	if self._depositUIQueue[ui] then
		self._depositUIQueue[ui] = nil
		self:_closeUIDo(nameOrObj)
		return
	end
end

function UIMgrExtension:_removeUIData(name)
	local wndQueue = self:getUIDataGroup(self._curGroupId) -- 获取当前组的UI数据组队列
	for i = #wndQueue, 1, -1 do
		if wndQueue[i].name == name then
			table.remove(wndQueue, i) -- 从队列中移除指定的UI数据
			GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
		end
	end
end

---内部方法，关闭界面
---@param nameOrObj string|any UI名称或对象
---@param noEnterAni boolean 是否无进入动画
---@param callFunc function 回调
---@param noAni boolean 是否无动画
function UIMgrExtension:_closeUI(nameOrObj, noEnterAni, callFunc, noAni)
	local name = self:_getUIName(nameOrObj)
	local ui = self:GetUI(name)
	if self._depositUIQueue[ui] then
		self:hideUI(nameOrObj)
		return
	end
	self:_closeUIDo(nameOrObj, noEnterAni, callFunc, noAni)
end

---清空所有UI 清除界面队列 + destroy所有界面
---@param clearSceneUIData boolean? 是否清除场景UI数据
function UIMgrExtension:clearAllUI(clearSceneUIData)
	-- local wndQueue = self:getUIDataGroup(self._curGroupId) -- 获取当前组的UI数据组队列
	-- for i = #wndQueue, 1, -1 do
	-- 	self:_closeUI(wndQueue[i].name)
	-- end
	self:removeAllUI()
	if clearSceneUIData ~= false then
		self._uiDataGroupQueue[self._curGroupId] = {}
	end
	if GameMsgMgr then
		GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
	end
	-- self:closeCurrentUI()
	self._curWnd = nil
	self._curWndData = nil
	DUtil.Destroy(self._clickEffect)
	self._clickEffect = nil
	DUtil.Destroy(self._dragEffect)
	self._dragEffect = nil

	self:CheckAllImageLoaders()
end

---移除所有UI destroy所有界面
function UIMgrExtension:removeAllUI()
	--保存当前界面数据到当前组
	if self._curWnd then
		table.insert(self:getUIDataGroup(self._curGroupId), self._curWndData)
		GameMsgMgr:sendEvent(GameMsgType.UIDataGroupQueueChange)
	end

	-- 清空当前界面记录
	if self._curWnd then
		self._curWnd = nil
		self._curWndData = nil
	end
	self._depositUIQueue = {}
	self:_RemoveAllUIImmediatelyDo()
end

---清除指定组的UI数据队列
---@param groupId number 组ID
function UIMgrExtension:clearUIDataGroup(groupId)
	if self._uiDataGroupQueue[groupId] then
		self._uiDataGroupQueue[groupId] = {}
	end
end

function UIMgrExtension:getCurWndName()
	if self._curWnd then
		return self._curWnd
	end
	return nil
end

---获取当前主指针屏幕坐标（真机多点时跟踪首个触摸，避免 Input.mousePosition 落在多点中心）
function UIMgrExtension:_getPointerPosition()
	if GV.IsEditor then
		return Input.mousePosition
	end
	if self._touchId and Input.touchCount > 0 then
		for i = 0, Input.touchCount - 1 do
			local touch = Input.GetTouch(i)
			if touch.fingerId == self._touchId then
				return touch.position
			end
		end
	end
	if Input.touchCount > 0 then
		return Input.GetTouch(0).position
	end
	return Input.mousePosition
end

---全局点击特效
function UIMgrExtension:globalClickAndDragEffect()
	if Input.GetMouseButtonDown(0) then
		self.isMouseDown = true
		if Input.touchCount > 0 then
			local touch = Input.GetTouch(0)
			self._touchId = touch.fingerId
			self._clickPos = touch.position
		else
			self._touchId = -1
			self._clickPos = Input.mousePosition
		end
		if not self._clickEffect and not self._clickEffectLoading then
			self._clickEffectLoading = true
			ResMgr:LoadGameObjectAsyncInOwner(Config.PrefabPath.GlobalClickEffect, function(obj)
				self._clickEffect = obj
				self:_playClickEffect(self._clickPos)
				self._clickEffectLoading = false
			end, ResMgr:GetGlobalResCarrier())
		else
			self:_playClickEffect(self._clickPos)
		end
	end

	if Input.GetMouseButtonUp(0) then
		self.isMouseDown = false
		self._touchId = nil
		if self._dragEffect then
			self._dragEffect:SetActive(false)
		end
	end

	if self.isMouseDown then
		local pointerPos = self:_getPointerPosition()
		if math.sqrt((pointerPos.x - self._clickPos.x) ^ 2 + (pointerPos.y - self._clickPos.y) ^ 2) < 10 then
			return
		end
		if not self._dragEffect and not self._dragEffectLoading then
			self._dragEffectLoading = true
			ResMgr:LoadGameObjectAsyncInOwner(Config.PrefabPath.GlobalDragEffect, function(obj)
				self._dragEffect = obj
				self._dragEffect.transform:SetParent(self.uiRoot.transform)
				self:_playDragEffect(self:_getPointerPosition())
				self._dragEffectLoading = false
			end, ResMgr:GetGlobalResCarrier())
		else
			self:_playDragEffect(pointerPos)
			if self._dragEffect and self._dragEffect.activeSelf == false then
				self._dragEffect:SetActive(true)
			end
		end
	end
end

function UIMgrExtension:GetUIRootParent()
	return self.uiRoot
end

function UIMgrExtension:GetUICoveRoleParent()
	if self.coveRoleRoot == nil then
		local obj = NewGameObject("CoveRole_UI", self.uiRoot.transform)
		obj:GetOrAddComponent(typeof(UnityEngine.RectTransform))
		obj.transform:SetSiblingIndex(1)
		self.coveRoleRoot = obj
	end
	return self.coveRoleRoot
end

function UIMgrExtension:GetUICanvasRoot()
	return self.uiRoot.transform:Find("CanvasRoot")
end

function UIMgrExtension:_playClickEffect(v2)
	if UICommonUtils.Checkobj(self._clickEffect) == false then
		return
	end
	if(self._clickEffect.activeSelf == false) then
		self._clickEffect:SetActive(true)
	end
	self._clickEffect.transform:SetParent(self.uiRoot.transform)
	self._clickEffect.transform.localPosition = UICommonUtils.ScreenToUILocalPos(self.uiRoot.transform, self.uiCamera, v2)
	-- if (self._clickEffectParticle == nil) then
	-- 	self._clickEffectParticle = self._clickEffect.transform:Find("Effect"):GetComponent("ParticleSystem")
	-- end
	self._clickEffectParticle = self._clickEffect.transform:Find("Effect"):GetComponent("ParticleSystem")
	self._clickEffectParticle:Simulate(0)
	self._clickEffectParticle:Play()

	-- 射线检测：若点击位置命中 Button 或 ScaleButton 则不播放点击音效
	local hitButton = false
	if (not EventSystem.current) then
		return
	end
	local pointerData = UnityEngine.EventSystems.PointerEventData(EventSystem.current)
	pointerData.position = v2
	local results = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	EventSystem.current:RaycastAll(pointerData, results)
	for i = 0, results.Count - 1 do
		local go = results[i].gameObject
		if go then
			-- 沿父节点向上最多检测5层，兼容按钮组件挂在图片父节点上的情况
			local trans = go.transform
			local depth = 0
			while trans ~= nil and depth < 5 do
				local g = trans.gameObject
				if g:GetComponent("Button") ~= nil or g:GetComponent("ScaleButton") ~= nil then
					hitButton = true
					break
				end
				trans = trans.parent
				depth = depth + 1
			end
		end
		if hitButton then break end
	end

	if not hitButton then
		LuaMain:play2DSound(string.format(Config.AudioPath.SE, "weaponselect"))
	end
end

function UIMgrExtension:_playDragEffect(v2)
	if self._dragEffect then
		self._dragEffect.transform.localPosition = UICommonUtils.ScreenToUILocalPos(self.uiRoot.transform, self.uiCamera, v2)
	end
end

function UIMgrExtension:hideClickEffect()
	self.isMouseDown = false
	self._touchId = nil
	if self._clickEffect then
		self._clickEffect:SetActive(false)
	end
	if self._dragEffect then
  		self._dragEffect:SetActive(false)
	end
end


--在PopUI时，主动请求所需服务器数据
--所有调用都进入串行队列，保证多次 popUI 按调用顺序依次执行。
--当某个 panel 需要等待服务器数据（异步）时，队列挂起，后续 popUI 等待，
--避免"无需等待的 B" 先于"需要等待的 A" 执行导致界面开启顺序颠倒。
function UIMgrExtension:_popUIPushData(panelName, callBack)
	table.insert(self._popUISeqQueue, { name = panelName, cb = callBack })
	self:_runNextPopUISeq()
end

function UIMgrExtension:_runNextPopUISeq()
	if self._popUISeqRunning or #self._popUISeqQueue == 0 then
		return
	end
	local item = table.remove(self._popUISeqQueue, 1)
	local needPushlist = GE.PopUIPushData[item.name]
	if needPushlist then
		self._popUISeqRunning = true
		Me:getFunctionDataReq(needPushlist, function()
			item.cb()
			self._popUISeqRunning = false
			self:_runNextPopUISeq()
		end)
	else
		item.cb()
		self:_runNextPopUISeq()
	end
end

return UIMgrExtension