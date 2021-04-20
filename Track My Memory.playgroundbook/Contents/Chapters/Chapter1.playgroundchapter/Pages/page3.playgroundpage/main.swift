/*:
 # Simple Paging
 
 Lastly, Simple Paging came in order to overcome **[External Fragmentation](glossary://externalfragmentation)** issues seen in [**Dynamic Partitioning**](@previous). Its idea looks a bit similar to [**Fixed Partitioning**](Fixed%20Partitioning)'s.

 ## How does Simple Paging work?
 
 In this technique, **[main memory](glossary://mainmemory)** is divided into small fixed chunks, which every single chunk has the same size of all others (haven't we've been [**there**](Fixed%20Partitioning) before? 🤔). The difference here is that these chunks, known as **[frames](glossary://frames)**, are from a relatively small size in comparasion to the total main memory's size. Each **[process](glossary://process)** that can possibly be stored into main memory is also divided into chunks of the same size as the memory's chunks. These process chunks are known as **[pages](glossary://pages)**. Finally, these pages are stored into avaliable frames.

 
## Strengths ✅:
 There isn't External Fragmentation, since frames are contiguous. Also, memory has more efficient usage, since pages can be allocated in different frames, not necessairily in a contiguous form.
 
## Weaknesses ❌:
 There is a bit of **[Internal Fragmentation](glossary://internalfragmentation)**. Exemplifying, if we have a process with a page which size is smaller than the frame's size, the remaining space in the frame is unused. At least, the unused frame space is usually small, causing less memory loss.
 
 
 # Let's play!
 
 In this game on the right, you are introduced to a four gigabyte sized main memory divided into 20 frames of equal size and nine applications.
 
 - Callout(How to play):
 Click the "Run" button under an app and see how it is divided and allocated into the frames! Also, try to run multiple apps you couldn't before because of the previous technique's limitations 😁

 Shall we play? 🤓
 
 - Note: Click on "Run My Code" when you're ready to start the game.

 */

//#-hidden-code
import PlaygroundSupport

PlaygroundPage.current.setLiveView(SimplePagingView())
//#-end-hidden-code
