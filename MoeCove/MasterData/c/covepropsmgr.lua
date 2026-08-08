local CoveProps = require("CoveProps")


---@class CovePropsMgr
local CovePropsMgr = class("CovePropsMgr")

function CovePropsMgr:ctor(...)

    ---@type CoveProps[]
    self.props = {}
end

---实例化
---@return CovePropsMgr covePropsMgr
function CovePropsMgr.instance()
	if (CovePropsMgr._instance == nil) then
		CovePropsMgr._instance = CovePropsMgr:new()
	end
	return CovePropsMgr._instance
end

---初始化战斗
function CovePropsMgr:Init()
    local coveScene = CoveManager.instance():getScene()
    if coveScene == nil then
        return
    end
    ---@type UnityEngine.Transform
    local trs = coveScene.coveInteractItem
    if IsNull(trs) then
       return 
    end
    DUtil.AutoCleanDelegate(trs.gameObject)
    local stuff = "CoveProps_"
    local childCount = trs.childCount
    for i = 0, childCount -1 do
        local trs = trs:GetChild(i)
        local name = trs.name
        if not string.startswith(name, stuff) then
			goto continue
		end
		local index = string.sub(name, string.len(stuff) + 1)
        index = tonumber(index)
        if index == nil then
           goto continue 
        end
        local coveProps = CoveProps:new(index, trs.gameObject)
        self.props[index] = coveProps
		::continue::
    end
end




function CovePropsMgr:GetCoveProps(covePropsId)
    return self.props[covePropsId]
end


function CovePropsMgr:Clear(covePropsId)
   self.props = {}
end


return CovePropsMgr
