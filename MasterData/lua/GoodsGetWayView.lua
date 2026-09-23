--物品信息

function Awake()       

    txtName = ComUtil.GetCom(name,"Text");
end

function OnInit()
    
end

function InitListener()
   
end


function OnOpen()
    UIUtil:ShowAction(bg, function()
        if(data ~= nil)then
            if goodsItem~=nil then
                goodsItem.Remove();
            end
            _,goodsItem=ResUtil:CreateGridItem(goodsNode.transform,data.type);
            goodsItem.Refresh(data.info,{isClick=false});
            
            local cfg = data.info:GetCfg();
    
            txtName.text = data.info:GetName();
    
            if(cfg.get_way)then
                for _,getWayId in ipairs(cfg.get_way)do
                    local cfgGetWay = Cfgs.CfgJump:GetByID(getWayId);
                    if(cfgGetWay)then
                        local go = ResUtil:CreateUIGO("Goods/GoodsGetWayItem",itemNode.transform);
                        local lua = ComUtil.GetLuaTable(go);  
                        lua.Set(cfgGetWay);
                    else
                        LogError("找不到获取途径配置" .. getWayId);
                    end
                end
            end
        end
    end, UIUtil.active2);
end

--关闭界面
function OnClickClose()    
    UIUtil:HideAction(bg, function()
        view:Close();
    end, UIUtil.active4);
end

