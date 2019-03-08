Unit myAlphavitTypes;

Interface

Const MIN_ELEMENT = 'a';
      MAX_ELEMENT = 'z';
Type oneWord = string;
     wordList = record
        info: oneWord;
        next: ^wordList;
     end;
     listPoint = ^wordList;
     
     wordQueue = record
        info: oneWord;
        next: ^wordQueue;
     end;
     queuePoint = ^wordQueue;
     element = char;

Implementation

Initialization

End.