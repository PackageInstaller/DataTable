local plotId = 0
local spineItem = nil

function Awake()
    local go = ResUtil:CreateUIGO("LovePlusPlot/LovePlusLive2DItem", itemParent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(PlayCallBack, EndCallBack, true)
    spineItem = lua
    CSAPI.SetGOActive(go,false)
end

function PlayCallBack()
    
end

function EndCallBack()
    
end

function Refresh(_data)
    plotId = _data
    if plotId then
        CSAPI.SetGOActive(spineItem.gameObject,true)
        spineItem.Refresh(plotId,LoadImgType.Main)
    end
end