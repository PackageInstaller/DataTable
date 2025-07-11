--[[
-- added by wsh @ 2017-11-30
-- UI管理系统：提供UI操作、UI层级、UI消息、UI资源加载、UI调度、UI缓存等管理
-- 注意：
-- 1、Window包括：Model、Ctrl、View、和Active状态等构成的一个整体概念
-- 2、所有带Window接口的都是操作整个窗口，如CloseWindow以后：整个窗口将不再活动
-- 3、所有带View接口的都是操作视图层展示，如CloseView以后：View、Model依然活跃，只是看不见，可看做切入了后台
-- 4、如果只是要监听数据，可以创建不带View、Ctrl的后台窗口，配置为nil，比如多窗口需要共享某控制model（配置为后台窗口）
-- 5、可将UIManager看做一个挂载在UIRoot上的不完全UI组件，但是它是Singleton，不使用多重继承，UI组件特性隐式实现
--]]

local Messenger = require "Framework.Common.Messenger"
local UIManager = BaseClass("UIManager", Singleton)

-- UIRoot路径
local UIRootPath = "UIRoot"
-- EventSystem路径
local EventSystemPath = "EventSystem"
-- UICamera路径
local UICameraPath = UIRootPath.."/UICamera"
local UICameraBlurPath = UIRootPath.."/UICameraBlur"
-- 分辨率
local Resolution = Vector2.New(1920, 1080)    -- 限制分辨率在1920/1080 ~ 2540/1080
local matchWidthOrHeight = 1
local maxWidth = 2540
local maxHeight = 1080
-- 窗口最大可使用的相对order_in_layer
local MaxOderPerWindow = 10
-- cs Tip
local UINoticeTip = CS.UINoticeTip.Instance

-- 构造函数
local function __init(self)
	local resolution = CS.UnityEngine.Screen.width / CS.UnityEngine.Screen.height
	if resolution < 1920 / 1080 then
		matchWidthOrHeight = 0
		maxWidth = 1920
		maxHeight = 1080
	elseif resolution >= 1920 / 1080 and resolution < 2540 / 1080 then
		matchWidthOrHeight = 1
		maxWidth = CS.UnityEngine.Screen.width / CS.UnityEngine.Screen.height * 1080
		maxHeight = 1080
	elseif resolution >= 2540 / 1080 then
		matchWidthOrHeight = 1
		maxWidth = 2540
		maxHeight = 1080
	end
	
	-- 成员变量
	-- 消息中心
	self.ui_message_center = Messenger.New()
	-- 所有存活的窗体
	self.windows = {}
	-- 所有可用的层级
	self.layers = {}
	-- 保持Model
	self.keep_model = {}
	-- 窗口记录队列
	self.__window_stack = {}
	-- 是否启用记录
	self.__enable_record = true
	--关闭的界面
	self.cancelWindows = {}
	
	-- 初始化组件
	self.gameObject = CS.UnityEngine.GameObject.Find(UIRootPath)
	self.transform = self.gameObject.transform
	self.camera_go = CS.UnityEngine.GameObject.Find(UICameraPath)
	self.camera_go_blur=CS.UnityEngine.GameObject.Find(UICameraBlurPath)
	if self.camera_go_blur ~= nil then
		self.camera_go_blur:SetActive(false)
		self.UIBlurCamera= self.camera_go_blur:GetComponent(typeof(CS.UnityEngine.Camera))
	end
	
	self.UICamera = self.camera_go:GetComponent(typeof(CS.UnityEngine.Camera))

	--self.UIBlurCamera= self.camera_go_blur:GetComponent(typeof(CS.UnityEngine.Camera))
	self.Resolution = Resolution
	self.MatchWidthOrHeight = matchWidthOrHeight
	self.maxWidth = maxWidth
	self.maxHeight = maxHeight
	self.MaxOderPerWindow = MaxOderPerWindow
	CS.UnityEngine.Object.DontDestroyOnLoad(self.gameObject)
	local event_system = CS.UnityEngine.GameObject.Find(EventSystemPath)
	CS.UnityEngine.Object.DontDestroyOnLoad(event_system)
	assert(not IsNull(self.transform))
	assert(not IsNull(self.UICamera))
	
	-- 初始化层级
	local layers = table.choose(Config.Debug and getmetatable(UILayers) or UILayers, function(k, v)
		return type(v) == "table" and v.OrderInLayer ~= nil and v.Name ~= nil and type(v.Name) == "string" and #v.Name > 0
	end)
	table.walksort(layers, function(lkey, rkey)
		return layers[lkey].OrderInLayer < layers[rkey].OrderInLayer 
	end, function(index, layer)
		assert(self.layers[layer.Name] == nil, "Aready exist layer : "..layer.Name)
		local go = CS.UnityEngine.GameObject(layer.Name)
		local trans = go.transform
		trans:SetParent(self.transform)
		local new_layer = UILayer.New(self, layer.Name)
		new_layer:OnCreate(layer)
		self.layers[layer.Name] = new_layer
	end)
end

-- 注册消息
local function AddListener(self, e_type, e_listener)
	self.ui_message_center:AddListener(e_type, e_listener)
end

-- 发送消息
local function Broadcast(self, e_type, ...)
	self.ui_message_center:Broadcast(e_type, ...)
end

-- 注销消息
local function RemoveListener(self, e_type, e_listener)
	self.ui_message_center:RemoveListener(e_type, e_listener)
end

-- 获取窗口
local function GetWindow(self, ui_name, active, view_active)
	local target = self.windows[ui_name]
	if target == nil then
		return nil
	end
	if active ~= nil and target.Active ~= active then
		return nil
	end
	if view_active ~= nil and target.View:GetActive() ~= view_active then
		return nil
	end
	return target
end

-- 初始化窗口
local function InitWindow(self, ui_name, window)
	local config = UIConfig[ui_name]
	assert(config, "No window named : "..ui_name..".You should add it to UIConfig first!")
	
	local layer = self.layers[config.Layer.Name]
	assert(layer, "No layer named : "..config.Layer.Name..".You should create it first!")
	
	window.Name = ui_name
	if self.keep_model[ui_name] then
		window.Model = self.keep_model[ui_name]
	elseif config.Model then
		window.Model = config.Model.New(ui_name)
	end
	if config.Ctrl then
		window.Ctrl = config.Ctrl.New(window.Model)
	end
	if config.View then
		window.View = config.View.New(layer, window.Name, window.Model, window.Ctrl)
	end
	window.Active = false
	window.Layer = layer
	window.PrefabPath = config.PrefabPath
	
	return window
end

local function PlayBGM(self,name)
	local  viewBGM =  table.first(Z_ViewBGM,function (a) return a.ViewName == name end)
	local bgmCom = Game.Scene:GetComponent("BgmComponent")
	if viewBGM == nil or (bgmCom:GetClipName() ~=nil and bgmCom:GetClipName() == bgmCom.ui_bgms[viewBGM.BGM]) then
		if viewBGM == nil  then
			Logger.Log(name.."viewBMG==NIL")
		end
		return
	end
	local againstComponent = Game.Scene:GetComponent("AgainstComponent")
	if not Game.Scene:GetComponent("AgainstComponent").StorySkip and
			Game.Scene:GetComponent("AgainstComponent").BattleWin and
			againstComponent.LevelType == LevelType.LevelTypeStory then
		return
	end
	if name == "UILaunchAtk" or name == "UIStoryChapter"  then
		if self.windows[name].View.model.mode == 1 then
			if bgmCom:GetClipName() ~= "HandBook" then
				coroutine.start(function()
					coroutine.waitforframes(3)
					Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI,"HandBook")
				end)
			end
			return
		end
	end
	coroutine.start(function()
		coroutine.waitforframes(3)
		Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI,viewBGM.BGM)
	end)
end

-- 激活窗口
local function ActivateWindow(self, target, ...)
	target.View.rectTransform.anchorMax = Vector2.New(0.5, 0.5)
	target.View.rectTransform.anchorMin = Vector2.New(0.5, 0.5)
	target.View.rectTransform.pivot = Vector2.New(0.5, 0.5)
	target.View.rectTransform.sizeDelta = Vector2.New(maxWidth, maxHeight)
	target.View.rectTransform:DOLocalRotate(Vector3.New(0, 0, 0), 0)
	
	assert(target)
	assert(target.IsLoading == false, "You can only activate window after prefab locaded!")
	-- 界面在最上面显示时（背景层）
	local count = table.count(self.__window_stack)
	if count > 0 and UIConfig[target.View:GetName()].Layer == UILayers.BackgroudLayer and self.__window_stack[count] == target.View:GetName() then
		if count > 1 then
			local name = self.__window_stack[count - 1]
			local wnd = self.windows[name]
			if wnd == nil then
				Logger.Log("windows has not wnd in window_stack: "..name)
				return
			end
			self.windows[name].View:OnDisViewTop()
		end
	end
	
	target.Model:Activate(...)
	target.View:SetActive(true)

	-- 界面在最上面显示时（背景层）
	if count > 0 and UIConfig[target.View:GetName()].Layer == UILayers.BackgroudLayer and self.__window_stack[count] == target.View:GetName() then
		target.View:OnViewTop()
        self:PlayBGM(target.View:GetName())
	end
end

-- 反激活窗口
local function Deactivate(self, target, _bool)
	-- 下一个背景最上面显示时（背景层）
	local count = table.count(self.__window_stack)
	if target == nil or target.View:GetName() == nil then
		Logger.LogError("log: Deactivate. target or target.View:GetName() is nil")
		return
	end
	if UIConfig[target.View:GetName()] == nil then
		Logger.LogError("log: Deactivate. UIConfig is nil, name: " .. target.View:GetName())
		return
	end
	if count > 0 and UIConfig[target.View:GetName()].Layer == UILayers.BackgroudLayer and self.__window_stack[count] == target.View:GetName() then
		target.View:OnDisViewTop()
	end
	
	target.Model:Deactivate()
	target.View:SetActive(false)

	if _bool then
		return
	end

	-- 将改隐藏窗口后面的窗口全部向前移动一个单位
	local targetCanvas = target.View.canvas
	assert(targetCanvas)
	for _,v in pairs(self.windows) do
		local canvas = v.View.canvas
		if not IsNull(canvas) and v.Layer:GetName() == target.Layer:GetName() and canvas:GetOrder() > targetCanvas:GetOrder() then
			canvas:MoveOrderOneUnit()
			v.View:OnSortingOrderChanged()
		end
	end

	-- 下一个背景最上面显示时（背景层）
	if count > 0 and UIConfig[target.View:GetName()].Layer == UILayers.BackgroudLayer and self.__window_stack[count] == target.View:GetName() then
		if count > 1 then
			local name = self.__window_stack[count - 1]
			local wnd = self.windows[name]
			if wnd == nil then
				Logger.Log("windows has not wnd in window_stack: "..name)
				return
			end
			self.windows[name].View:OnViewTop()
			self:PlayBGM(name)
		end
	end
end

-- 打开窗口：私有，必要时准备资源
local function InnerOpenWindow(self, target,ui_name,...)
	assert(target)
	assert(target.Model)
	assert(target.Ctrl)
	assert(target.View)
	assert(target.Active == false, "You should close window before open again!")

	target.Active = true
	local has_view = target.View ~= UIBaseView
	local has_prefab_res = target.PrefabPath and #target.PrefabPath > 0
	local has_loaded = not IsNull(target.View.gameObject)
	local need_load = has_view and has_prefab_res and not has_loaded
	if not need_load then
		ActivateWindow(self, target, ...)
	elseif not target.IsLoading then
		target.IsLoading = true
		local params = SafePack(...)
		GameObjectPool:GetInstance():GetGameObjectAsync(target.PrefabPath, function(go)
			if IsNull(go) then
				return
			end
			local trans = go.transform
			trans:SetParent(target.Layer.transform)
			trans.name = target.Name

			target.IsLoading = false
			target.View:OnCreate()
			if target.Active then
				ActivateWindow(self, target, SafeUnpack(params))
			end
		end)
	end
end

-- 关闭窗口：私有
local function InnerCloseWindow(self, target,_bool)
	assert(target)
	assert(target.Model)
	assert(target.Ctrl)
	assert(target.View)

	if target.Active then
		if not _bool then
			target.Model:RealDeactive()
		end
		Deactivate(self, target, _bool)
		target.Active = false
	end
end

local function AddCancelWindows(self, ui_name, type)
	if not type then type = 1 end
	self.cancelWindows[ui_name] = type
end

--local function CheckWindow(self, ui_name)
--	if self.cancelWindows[ui_name] then
--		if self.cancelWindows[ui_name] == 2 then
--			UIUtil.ToolTipFourth(LangUtil.GetSysLang(861))
--		end
--		return true
--	end
--	return false
--end

local function OpenWindow(self, ui_name, ...)
	Logger.Log("==========--open ui==============:"..ui_name)
	local data = ...
	-- if data ~= nil then Logger.Log(table.dump(data)) end
	local isOpen, errorMsg = UIPublic.CheckUIOpen(ui_name, data)
	if not isOpen then
        UIUtil.ToolTipFourth(errorMsg)
		return
	end
	local target = self:GetWindow(ui_name)
	if not target then
		local window = UIWindow.New()
		self.windows[ui_name] = window
		target = InitWindow(self, ui_name, window)
	end
	local layer = UIConfig[ui_name].Layer
	if layer == UILayers.BackgroudLayer then
		DataManager:GetInstance():Broadcast(DataMessageNames.ON_UI_TRANSIT, ui_name)
	end
	coroutine.start(function ()
		self:AddToWindowStack(target.Name)
		InnerCloseWindow(self, target)
		InnerOpenWindow(self, target,ui_name,data)
	end)
end

-- 关闭窗口：公有
local function CloseWindow(self, ui_name)
	Logger.Log("==========--close ui==============:"..ui_name)
	local target = self:GetWindow(ui_name, true)
	if not target then
		return
	end
	local layer = UIConfig[ui_name].Layer
	if layer == UILayers.BackgroudLayer then
		DataManager:GetInstance():Broadcast(DataMessageNames.ON_UI_TRANSIT)
	end
	coroutine.start(function ()
		InnerCloseWindow(self, target)
		self:RemoveFormWindowStack(target.Name, false)
	end)
end

-- 关闭层级所有窗口, -- 暂时用不上，需要的话不要私自打开
local function CloseWindowByLayer(self, layer)
	coroutine.start(function()
		if layer == UILayers.BackgroudLayer then
			DataManager:GetInstance():Broadcast(DataMessageNames.ON_UI_TRANSIT)
		end
		for _,v in pairs(self.windows) do
			if v.Layer:GetName() == layer.Name then
				InnerCloseWindow(self, v)
			end
		end
	end)
end

-- 清除掉现在打开的一些窗口
local function CloseWindowByStackExcept(self, name) 
	local tab = table.clone(self.__window_stack)
	table.walk(tab, function (k, v)
		if v ~= name then
			self:CloseWindow(v)
		end
	end)
end

-- 关闭其它层级窗口, -- 暂时用不上，需要的话不要私自打开
local function CloseWindowExceptLayers(self, layers)
	for _,v in pairs(self.windows) do
		if not table.any(layers, function (val) return v.Layer:GetName() ~= val.Name end) then
			InnerCloseWindow(self, v)
		end
	end
end

---- 关闭所有窗口, -- 暂时用不上，需要的话不要私自打开
local function CloseAllWindows(self)
	local tab = table.clone(self.__window_stack)
	for i = table.count(tab), 1, -1 do
		local window = self.windows[tab[i]]
		if window and window.Active then
			CloseWindow(self, tab[i])
		end
	end
end

---- 展示窗口, -- 暂时用不上，需要的话不要私自打开
--local function OpenView(self, ui_name, ...)
--	local target = self:GetWindow(ui_name)
--	assert(target, "Try to show a window that does not exist: "..ui_name)
--	if not target.View:GetActive() then
--		target.View:SetActive(true)
--	end
--end
--
---- 隐藏窗口, -- 暂时用不上，需要的话不要私自打开
--local function CloseView(self, ui_name)
--	local target = self:GetWindow(ui_name)
--	assert(target, "Try to hide a window that does not exist: "..ui_name)
--	if target.View:GetActive() then
--		target.View:SetActive(false)
--	end
--end

local function InnerDelete(plugin)
	if plugin.__ctype == ClassType.instance then
		plugin:Delete()
	end
end

local function InnerDestroyWindow(self, ui_name, target, include_keep_model)
	-- 说明：一律缓存，如果要真的清理，那是清理缓存时需要管理的功能
	GameObjectPool:GetInstance():RecycleGameObject(self.windows[ui_name].PrefabPath, target.View.gameObject)
	if include_keep_model then
		self.keep_model[ui_name] = nil
		InnerDelete(target.Model)
	elseif not self.keep_model[ui_name] then
		InnerDelete(target.Model)
	end
	InnerDelete(target.Ctrl)
	InnerDelete(target.View)
	self.windows[ui_name] = nil
end

-- 销毁窗口: UI最好不要用
local function DestroyWindow(self, ui_name, include_keep_model)
	local target = self:GetWindow(ui_name)
	if not target then
		return
	end
	InnerCloseWindow(self, target)
	InnerDestroyWindow(self, ui_name, target, include_keep_model)
	self:RemoveFormWindowStack(ui_name, false)
end

-- 销毁并不回收清除资源: UI最好不要用
local function DestroyWindowNoRecycle(self,ui_name)
	local target = self:GetWindow(ui_name)
	if not target then
		return
	end
	coroutine.start(function ()
		if UIConfig[ui_name].Layer == UILayers.BackgroudLayer then
			DataManager:GetInstance():Broadcast(DataMessageNames.ON_UI_TRANSIT)
		end
		InnerCloseWindow(self, target)
		self:RemoveFormWindowStack(ui_name, false)
		GameObjectPool:GetInstance():RecycleGameObject(self.windows[ui_name].PrefabPath, target.View.gameObject)
		GameObjectPool:GetInstance():DestroyGameObjectByPath(self.windows[ui_name].PrefabPath)
		InnerDelete(target.Ctrl)
		InnerDelete(target.View)
		self.windows[ui_name] = nil
	end)
end

-- 打开记录栈
local function OpenWindowStack(self, defaultName)
	assert(defaultName)
	if table.count(self.__window_stack) <= 0 then
		self:OpenWindow(defaultName)
		return
	end
	if string.IsNullOrEmpty(self:GetLastBgWindowName()) then
		if table.count(self.__window_stack) > 0 then
			error("There is something wrong!")
		end
		return
	end
	self.__enable_record = false
	for i = 1, table.count(self.__window_stack) do
		local ui_name = self.__window_stack[i]
		Logger.Log("Open WindowStack: "..ui_name)
		self:OpenWindow(ui_name)
		coroutine.waituntil(function () return self:GetWindow(ui_name, true).View ~= nil end)
		coroutine.waitforframes(1)
	end
	self.__enable_record = true
end

---- 销毁层级所有窗口, -- 暂时用不上，需要的话不要私自打开
--local function DestroyWindowByLayer(self, layer, include_keep_model)
--	for k,v in pairs(self.windows) do
--		if v.Layer:GetName() == layer.Name then
--			InnerCloseWindow(self, v)
--			InnerDestroyWindow(self, k, v, include_keep_model)
--		end
--	end
--end

-- 销毁其它层级窗口，**禁用这个**（场景切换时用到，这里就不要清掉窗口记录了）
local function DestroyWindowExceptLayer(self, layers, include_keep_model)
	for k,v in pairs(self.windows) do
		if not table.any(layers, function (val) return v.Layer:GetName() == val.Name end) then
			xpcall(function ()
				InnerCloseWindow(self, v, true)
				InnerDestroyWindow(self, k, v, include_keep_model)
			end, function (msg)
				Logger.LogError("DestroyWindowExceptLayer: "..msg)
			end)
		end
	end
end

---- 销毁所有窗口, -- 暂时用不上，需要的话不要私自打开
--local function DestroyAllWindow(self, ui_name, include_keep_model)
--	for k,v in pairs(self.windows) do
--		InnerCloseWindow(self, v)
--		InnerDestroyWindow(self, k, v, include_keep_model)
--	end
--end

-- 设置是否保持Model
local function SetKeepModel(self, ui_name, keep)
	if keep then
		local target = self:GetWindow(ui_name)
		assert(target, "Try to keep a model that window does not exist: "..ui_name)
		self.keep_model[ui_name] = target.Model
	else
		self.keep_model[ui_name] = nil
	end
end

-- 获取保持的Model
local function GetKeepModel(self, ui_name)
	return self.keep_model[ui_name]
end

-- 加入窗口记录栈
local function AddToWindowStack(self, ui_name)
	if not self.__enable_record then
		return
	end
	if UIConfig[ui_name].Layer ~= UILayers.BackgroudLayer then
		return
	end
	if table.any(self.__window_stack, function (v) return v == ui_name end) then
		local target = self:GetWindow(ui_name, true)
		if not target then return end
		InnerCloseWindow(self, target)
		self:RemoveFormWindowStack(target.Name, false)
	end
	table.insert(self.__window_stack, ui_name)
	-- 保持Model
	self:SetKeepModel(ui_name, true)
end

-- 从窗口记录栈中移除
local function RemoveFormWindowStack(self, ui_name, only_check_top)
	if not self.__enable_record then
		return
	end
	if UIConfig[ui_name].Layer ~= UILayers.BackgroudLayer then
		return
	end
	local index = table.indexof(self.__window_stack, ui_name)
	if not index then
		return
	end
	if only_check_top and index ~= table.count(self.__window_stack) then
		Logger.LogError(ui_name.." is not top in windowStack")
		return
	end
	local ui_name = table.remove(self.__window_stack, index)
	-- 取消Model保持
	self:SetKeepModel(ui_name, false)
end

-- 获取记录栈
local function GetWindowStack(self)
	return self.__window_stack
end

-- 清空记录栈：退出游戏的时候清空
local function ClearWindowStack(self)
	table.walk(self.__window_stack, function (k, v) 
		self:RemoveFormWindowStack(v)
	end)
	self.__window_stack = {}
end

-- 获取最后添加的一个背景窗口索引
local function GetLastBgWindowIndexInWindowStack(self)
	local bg_index = -1
	for i = 1, table.count(self.__window_stack) do
		local ui_name = self.__window_stack[i]
		if UIConfig[ui_name].Layer == UILayers.BackgroudLayer then
			bg_index = i
		end
	end
	return bg_index
end

-- 获取最后一个背景层的UI
local function GetLastBgWindowName(self)
	local bg_index = self:GetLastBgWindowIndexInWindowStack()
	return self.__window_stack[bg_index]
end

---- 弹出栈
---- 注意：从上一个记录的背景UI开始弹出之后所有被记录的窗口
--local function PopWindowStack(self)
--	local bg_index = self:GetLastBgWindowIndexInWindowStack()
--	if bg_index == -1 then
--		-- 没找到背景UI
--		if table.count(self.__window_stack) > 0 then
--			error("There is something wrong!")
--		end
--		return
--	end
--	self.__enable_record = false
--	local end_index = table.count(self.__window_stack)
--	for i = end_index, bg_index + 1, -1 do
--		local ui_name = self.__window_stack[i]
--		self:OpenWindow(ui_name)
--	end
--	self.__enable_record = true
--end

-- 展示Tip：单按钮
local function OpenOneButtonTip(self, title, content, btnText, callback)
	local ui_name = UIWindowNames.UINoticeTip
	local cs_func = UINoticeTip.ShowOneButtonTip
	self:OpenWindow(ui_name, cs_func, title, content, btnText, callback)
end

-- 展示Tip：双按钮
local function OpenTwoButtonTip(self, title, content, btnText1, btnText2, callback1, callback2)
	local ui_name = UIWindowNames.UINoticeTip
	local cs_func = UINoticeTip.ShowTwoButtonTip
	self:OpenWindow(ui_name, cs_func, title, content, btnText1, btnText2, callback1, callback2)
end

-- 展示Tip：三按钮
local function OpenThreeButtonTip(self, title, content, btnText1, btnText2, btnText3, callback1, callback2, callback3)
	local ui_name = UIWindowNames.UINoticeTip
	local cs_func = UINoticeTip.ShowThreeButtonTip
	self:OpenWindow(ui_name, cs_func, title, content, btnText1, btnText2, btnText3, callback1, callback2, callback3)
end

-- 隐藏Tip
local function CloseTip(self)
	local ui_name = UIWindowNames.UINoticeTip
	self:CloseWindow(ui_name)
end

-- 等待View层窗口创建完毕（资源加载完毕）：用于协程
local function WaitForViewCreated(self, ui_name)
	local window = self:GetWindow(ui_name, true)
	assert(window ~= nil, "Try to wait for a not opened window : "..ui_name)
	if IsNull(window.View.gameObject) then
		window.View:WaitForCreated()
	end
	return window
end

-- 等待Tip响应：用于协程，返回点击序号，-1表示无响应且窗口被异常关闭
local function WaitForTipResponse(self)
	local ui_name = UIWindowNames.UINoticeTip
	local window = self:WaitForViewCreated(ui_name)
	return window.Model:WaitForResponse()
end

-- 析构函数
local function __delete(self)
	self.ui_message_center = nil
	self.windows = nil
	self.layers = nil
	self.keep_model = nil
end

UIManager.__init = __init
UIManager.AddListener = AddListener
UIManager.Broadcast = Broadcast
UIManager.RemoveListener = RemoveListener
UIManager.GetWindow = GetWindow
UIManager.OpenWindow = OpenWindow
UIManager.CloseWindow = CloseWindow
UIManager.CloseWindowByLayer = CloseWindowByLayer
UIManager.CloseWindowExceptLayers = CloseWindowExceptLayers
UIManager.CloseAllWindows = CloseAllWindows
UIManager.OpenView = OpenView
UIManager.CloseView = CloseView
UIManager.DestroyWindow = DestroyWindow
UIManager.DestroyWindowByLayer = DestroyWindowByLayer
UIManager.DestroyWindowExceptLayer = DestroyWindowExceptLayer
UIManager.DestroyAllWindow = DestroyAllWindow
UIManager.SetKeepModel = SetKeepModel
UIManager.GetKeepModel = GetKeepModel
UIManager.AddToWindowStack = AddToWindowStack
UIManager.RemoveFormWindowStack = RemoveFormWindowStack
UIManager.GetLastBgWindowIndexInWindowStack = GetLastBgWindowIndexInWindowStack
UIManager.GetWindowStack = GetWindowStack
UIManager.ClearWindowStack = ClearWindowStack
UIManager.PopWindowStack = PopWindowStack
UIManager.OpenOneButtonTip = OpenOneButtonTip
UIManager.OpenTwoButtonTip = OpenTwoButtonTip
UIManager.OpenThreeButtonTip = OpenThreeButtonTip
UIManager.CloseTip = CloseTip
UIManager.WaitForViewCreated = WaitForViewCreated
UIManager.WaitForTipResponse = WaitForTipResponse
--UIManager.MoveAllWindowToBlur=MoveAllWindowToBlur
--UIManager.MoveAllWindowToSelfLayer=MoveAllWindowToSelfLayer
UIManager.DestroyWindowNoRecycle=DestroyWindowNoRecycle
UIManager.CloseWindowByStackExcept = CloseWindowByStackExcept 
UIManager.OpenWindowStack = OpenWindowStack
UIManager.GetLastBgWindowName = GetLastBgWindowName
UIManager.AddCancelWindows = AddCancelWindows
UIManager.PlayBGM = PlayBGM
UIManager.__delete = __delete

return UIManager;