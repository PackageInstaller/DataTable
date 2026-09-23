local items={};
function Refresh(list)
    --排序
    if list==nil then
        LogError("列表不能为空！"..table.tostring(list))
        do return end
    end
    table.sort(list,SortList)
    local str=ItemPoolGoodsGradeStr[list[1]:GetRewardLevel()]
    CSAPI.SetText(txtGrade,str);
    ItemUtil.AddItems("FesDream/FesDreamRewardGrid",items,list,gridNode);
end

function SortList(a,b)
    return a:GetIndex()<b:GetIndex();
end
