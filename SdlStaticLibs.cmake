function(SdlStaticLibs name)
	find_package(SDL2 REQUIRED)
	find_package(OpenGL REQUIRED)
	find_library(COREAUDIO_LIBRARY CoreAudio)
	find_library(AUDIOTOOLBOX_LIBRARY AudioToolbox)
	find_library(AUDIOUNIT_LIBRARY AudioUnit)
	find_library(FORCEFEEDBACK_LIBRARY ForceFeedback)
    find_library(CARBON_LIBRARY Carbon)
	find_library(COCOA_LIBRARY Cocoa)
	find_library(IOKIT_LIBRARY IOKit)
	
	
	
	target_link_libraries(${name} ${SDL2_LIBRARY})
	target_link_libraries(${name} ${COREAUDIO_LIBRARY} ${AUDIOTOOLBOX_LIBRARY} ${AUDIOUNIT_LIBRARY} ${FORCEFEEDBACK_LIBRARY} ${CARBON_LIBRARY} ${COCOA_LIBRARY} ${IOKIT_LIBRARY})
	target_link_libraries(${name} ${OPENGL_gl_LIBRARY})
	
endfunction(SdlStaticLibs)
