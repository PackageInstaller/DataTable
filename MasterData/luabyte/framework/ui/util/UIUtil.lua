
local UIUtil = {}

local function GetChild(trans, index)
	return trans:GetChild(index)
end

local function GetChildCount(trans)
	return trans.childCount
end

-- 注意：根节点不能是隐藏状态，否则路径将找不到
local function FindComponent(trans, ctype, path)
	assert(trans ~= nil)
	assert(ctype ~= nil)
	
	local targetTrans = trans
	if path ~= nil and type(path) == "string" and #path > 0 then
		targetTrans = trans:Find(path)
	end
	if targetTrans == nil then
		return nil
	end
	local cmp = targetTrans:GetComponent(ctype)
	if cmp ~= nil then
		return cmp
	end
	return targetTrans:GetComponentInChildren(ctype)
end

--try get component , if it returns nil create one attend on it 
local function TryGetComponents( trans, ctype )
	-- body
	if IsNull(trans) or IsNull(ctype) then
		return nil 
	end
	local instance = trans:GetComponent(ctype)
	if IsNull(instance) then 
		instance = trans.gameObject:AddComponent(ctype)
	end
	return instance
end

-- remove the component by the cstype 
local function RemoveComponentByType( trans , ctype )
	-- body
	if IsNull(trans) or IsNull(ctype) then
		return false 
	end
	local instance = trans:GetComponent(ctype)
	if not IsNull(instance) then 
		CS.UnityEngine.Component.Destroy(instance)
		return true 
	end
	return false 
end

local function FindTrans(trans, path)
	return trans:Find(path)
end

local function FindText(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Text), path)
end

local function FindImage(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Image), path)
end

local function FindButton(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Button), path)
end

local function FindInput(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.InputField), path)
end

local function FindSlider(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Slider), path)
end

local function FindScrollRect(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.ScrollRect), path)
end

local function FindCircularScrollView(trans, path)
	return FindComponent(trans, typeof(CS.CircularScrollView.UICircularScrollView), path)
end

-- 获取直属画布
local function GetCanvas(ui_component)
	-- 初始化直属画布
	local canvas = nil
	-- if ui_component._class_type == UILayer then
	-- 	canvas = ui_component
	-- else
		local now_holder = ui_component.holder
		while now_holder ~= nil do	
			local var = ui_component:GetComponents(UICanvas)
			if table.count(var) > 0 then
				assert(table.count(var) == 1)
				canvas = var[1]
				break
			end
			now_holder = now_holder.holder
		end
	-- end
	assert(canvas ~= nil)
	return canvas
end

UIUtil.GetChild = GetChild
UIUtil.GetChildCount = GetChildCount
UIUtil.FindComponent = FindComponent
UIUtil.FindTrans = FindTrans
UIUtil.FindText = FindText
UIUtil.FindImage = FindImage
UIUtil.FindButton = FindButton
UIUtil.FindInput = FindInput
UIUtil.FindSlider = FindSlider
UIUtil.FindScrollRect = FindScrollRect
UIUtil.FindCircularScrollView = FindCircularScrollView
UIUtil.TryGetComponents = TryGetComponents
UIUtil.RemoveComponentByType = RemoveComponentByType
return ConstClass("UIUtil", UIUtil)