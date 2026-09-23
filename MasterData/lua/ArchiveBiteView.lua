local layout = nil
local curDatas = nil

function Awake()
    layout = UIInfiniteUnlimited.New()
    layout:Init("Archive4/ArchiveBiteItem",LayoutCallBack,itemParent,10,{40,40})
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnInit()
    UIUtil:AddTop2("ArchiveBite",topParent.gameObject,OnClickBack)
end

function Update()
    layout:Update()
end

function OnOpen()
    SetDatas()
    RefreshPanel()
end

function SetDatas()
    curDatas = {}
    local cfgs = Cfgs.CfgArchiveBite:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            table.insert(curDatas,{
                cfg = v,
                GetSize = function(self)
                    local count = math.ceil(#self.cfg.infos/5)
                    local baseHeight = 276
                    return baseHeight + (count - 1) * 294
                end
            })
        end
    end

    if #curDatas > 0 then
        table.sort(curDatas,function (a,b)
            return a.cfg.id<b.cfg.id
        end)
    end
end

function RefreshPanel()
    SetItems()
end

function SetItems()
    layout:IEShowList(curDatas,nil,1)
end

function OnClickBack()
    view:Close()
end

