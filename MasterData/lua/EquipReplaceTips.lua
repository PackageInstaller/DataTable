local items={};
--- func data=es:装备列表 ids:要替换的id列表 cardId:卡牌id
function OnOpen()
    if data and data.es then
        ItemUtil.AddItems("Grid/EquipItem2", items, data.es, layout,OnClickGrid)
    end    
end

function OnClickGrid(tab)
    CSAPI.OpenView("EquipFullInfo",tab.data,3)
end

function OnClickS()
    if data then
        EquipProto:EquipUps(data.cardId,data.ids);
    end
    view:Close();
end

function OnClickC()
    view:Close();
end