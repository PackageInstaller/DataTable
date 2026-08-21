local TSButton = BaseClass("TSButton",UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self, unity_tsButton )
	base.OnCreate(self)
	-- Unity侧原生组件
	self.unity_tsButton = unity_tsButton 
	
	if IsNull(self.unity_tsButton) and IsNull(self.gameObject) then
		self.gameObject = self.unity_tsButton.gameObject
		self.transform = self.unity_tsButton.transform
	end
    self.onClick = nil 
    if self.unity_tsButton then 
        self.unity_tsButton.onClick = Bind(self,self.OnClickItem)
    end
end

local function OnClickItem(self,go)
    if self.onClick then 
        self.onClick(go)
    end
end

local function OnDestroy(self)
    if self.unity_tsButton then 
        self.unity_tsButton.onClick = nil 
    end
    self.onClick = nil 
    base.OnDestroy(self)
end

TSButton.OnDestroy = OnDestroy
TSButton.OnCreate = OnCreate
TSButton.OnClickItem = OnClickItem

return TSButton