
function Awake()
    buffItems = {};
end

--更新Buff
function UpdateBuff(buffs)
   if(buffItems)then
        for uid,buffItem in pairs(buffItems)do
            if(buffs == nil or buffs[uid] == nil)then
                buffItems[uid] = nil;
                buffItem.Remove();          
            end
        end
   end

   if(buffs ~= nil)then
       for uid,buff in pairs(buffs)do
           local buffItem = buffItems[uid];
           local shieldType,shieldCount = buff:GetShield();--护盾buff不显示
           if(buffItem == nil and buff:IsShow() and not shieldCount)then                  
               local go =  ResUtil:CreateUIGO("Fight/BuffItem",nodes.transform);
               buffItem = ComUtil.GetLuaTable(go);
               buffItems[uid] = buffItem;    
           end  
           if(buffItem)then
               buffItem.SetBuff(buff);
           end
       end
   end       
end

function OnRecycle()
    buffItems = {};
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
nodes=nil;
view=nil;
end
----#End#----