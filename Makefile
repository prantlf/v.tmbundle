BUNDLES=${HOME}/Library/Application Support/TextMate/Managed/Bundles
NAME=V.tmbundle
TARGET=${BUNDLES}/${NAME}

test ::
	plutil info.plist Preferences/* Syntaxes/*

install ::
	mkdir -p "${TARGET}/Preferences" "${TARGET}/Syntaxes"
	cp README.mdown "${TARGET}/"
	cp Changes.json "${TARGET}/"
	plutil -convert binary1 -o "${TARGET}/info.plist" info.plist
	plutil -convert binary1 -o "${TARGET}/Preferences/Comments.tmPreferences" Preferences/Comments.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Preferences/Folding.tmPreferences" Preferences/Folding.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Preferences/Indentation.tmPreferences" Preferences/Indentation.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Preferences/SymbolsFunctions.tmPreferences" Preferences/SymbolsFunctions.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Preferences/SymbolsMethods.tmPreferences" Preferences/SymbolsMethods.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Syntaxes/V.tmLanguage" Syntaxes/V.tmLanguage

uninstall ::
	rm -r ${TARGET}

changes ::
	git log \
    --pretty=format:'{"commit":"%H","date":"%aI","author":"%aN","summary":"%f"},' | \
    perl -pe 'BEGIN{print "{\"commits\":["}; END{print "],\"name\":\"V\"}"}' | \
    perl -pe 's/},]/}]/' > Changes.json
