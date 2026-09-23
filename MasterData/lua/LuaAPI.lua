--释放Table组件对象的引用
function DisposeTable(luaTable)
--    if(luaTable.gameObject)then
--        LogError(luaTable.gameObject.name);
--    end
    UIUtil:RemoveRef(luaTable);
end
