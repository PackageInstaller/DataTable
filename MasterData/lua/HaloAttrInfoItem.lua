local itemList={};

function Refresh(_data)
    if _data then
        local list={};
        local isLock=_data.halo:GetLv()<_data.cfg.index
        CSAPI.SetGOActive(lockObj,isLock);
        local color1= "00ffbf" 
        local addColor= "ffc146" 
        local color2= "00ffbf" 
        CSAPI.SetText(txtLv,LanguageMgr:GetByID(1033).._data.cfg.index);
        --对比当前等级和上个等级新增的属性，新增的提示解锁光环，旧的提示光环升级，特效提供的固定显示自身,两个属性相同时不显示
        local types=_data.cfg.use_types
        if types~=nil then
            for k, v in ipairs(types) do
                local eCfg=Cfgs.CfgCardPropertyEnum:GetByID(v);
                if eCfg==nil then
                    LogError("查找卡牌属性表时出错！key:"..tostring(v));
                end
                local state=1; --1:光环解锁属性 2:新增属性 3:属性增长 4：与上级的一致
                local sDesc=string.format("<color=#ff8746>%s</color>",LanguageMgr:GetByID(100042)) ;
                local _num=_data.cfg[eCfg.sFieldName] or 0
                if _data.oldCfg~=nil then
                    state=2;
                    for _, val in ipairs(_data.oldCfg.use_types) do
                        if v==val then
                            local _num2=_data.oldCfg[eCfg.sFieldName] or 0
                            if _num==_num2 then
                                state=4;
                            else
                                state=3;
                                sDesc=string.format("<color=#ff8746>%s</color>",LanguageMgr:GetByID(100043))
                            end
                        end
                    end
                end
                if state~=4 then--未增长的属性不显示描述
                    table.insert(list,{cfg=eCfg,name=eCfg.sName,val=HaloUtil.GetPropertyValueStr(eCfg.sFieldName,_num),color1=color1,addColor=addColor,sDesc=sDesc,color3="ff8746"});
                end
            end
        end
        if _data.effect~=nil then
            local sDesc=string.format("<color=#ff8746>%s</color>",LanguageMgr:GetByID(100041)) 
             for k, v in ipairs(_data.effect.use_types) do
                local eCfg=Cfgs.CfgCardPropertyEnum:GetByID(v);
                if eCfg then
                    local _num=_data.effect[eCfg.sFieldName] or 0
                    table.insert(list,{cfg=eCfg,name=eCfg.sName,val=HaloUtil.GetPropertyValueStr(eCfg.sFieldName,_num),color1=color1,addColor=addColor,sDesc=sDesc,color3="ff8746"});
                end
            end
        end
        if _data.cfg.coorId and _data.cfg.index>1 then
            table.insert(list,{desc=LanguageMgr:GetByID(100036),color2=color2});
        end
        ItemUtil.AddItems("Halo/HaloEquipItem2", itemList, list, node,nil,1,isLock)
    end
end
