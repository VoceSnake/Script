print("Coast云端脚本支持")
print("平台:Github")
print("TTs播报开始...")
import "android.speech.tts.*"
mTextSpeech = TextToSpeech(activity, TextToSpeech.OnInitListener{
  onInit=function(status)
    --如果装载TTS成功
    if (status == TextToSpeech.SUCCESS)
      result = mTextSpeech.setLanguage(Locale.CHINESE);
      --[[LANG_MISSING_DATA-->语言的数据丢失
          LANG_NOT_SUPPORTED-->语言不支持]]
      if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
        --不支持中文
        print("您的手机不支持中文语音播报功能。");
        result = mTextSpeech.setLanguage(Locale.ENGLISH);
        if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
          --不支持中文和英文
          print("您的手机不支持语音播报功能。");
         else
          --不支持中文但支持英文
          --语调,1.0默认
          mTextSpeech.setPitch(1);
          --语速,1.0默认
          mTextSpeech.setSpeechRate(1);
          mTextSpeech.speak("hello,MLua Manual.Hello,World!", TextToSpeech.QUEUE_FLUSH, nil);
        end
       else
        --支持中文
        --语调,1.0默认
        mTextSpeech.setPitch(1);
        --语速,1.0默认
        mTextSpeech.setSpeechRate(1);
        mTextSpeech.speak("Coast云端Github脚本执行成功", TextToSpeech.QUEUE_FLUSH, nil);
      end
    end
  end
});
print("本地时间.."..os.date("%Y-%m-%d %H:%M:%S"))
print("配置Dump中..")
function dump(o)
  local t = {}
  local _t = {}
  local _n = {}
  local space, deep = string.rep(' ', 2), 0
  local function _ToString(o, _k)
    if type(o) == ('number') then
      table.insert(t, o)
     elseif type(o) == ('string') then
      table.insert(t, string.format('%q', o))
     elseif type(o) == ('table') then
      local mt = getmetatable(o)
      if mt and mt.__tostring then
        table.insert(t, tostring(o))
       else
        deep = deep + 2
        table.insert(t, '{')

        for k, v in pairs(o) do
          if v == _G then
            table.insert(t, string.format('\r\n%s%s\t=%s ;', string.rep(space, deep - 1), k, "_G"))
           elseif v ~= package.loaded then
            if tonumber(k) then
              k = string.format('[%s]', k)
             else
              k = string.format('[\"%s\"]', k)
            end
            table.insert(t, string.format('\r\n%s%s\t= ', string.rep(space, deep - 1), k))
            if v == NIL then
              table.insert(t, string.format('%s ;',"nil"))
             elseif type(v) == ('table') then
              if _t[tostring(v)] == nil then
                _t[tostring(v)] = v
                local _k = _k .. k
                _t[tostring(v)] = _k
                _ToString(v, _k)
               else
                table.insert(t, tostring(_t[tostring(v)]))
                table.insert(t, ';')
              end
             else
              _ToString(v, _k)
            end
          end
        end
        table.insert(t, string.format('\r\n%s}', string.rep(space, deep - 1)))
        deep = deep - 2
      end
     else
      table.insert(t, tostring(o))
    end
    table.insert(t, " ;")
    return t
  end

  t = _ToString(o, '')
  return table.concat(t)
end

print("环境配置获得成功:\n"..dump(debug.getinfo(1)))